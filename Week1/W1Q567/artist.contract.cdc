//https://play.onflow.org/7c161574-8c0b-4860-810d-498d55580d7c?type=script&id=82ca23c2-09a7-4293-9119-a891b0d7d3a9
pub contract Artist {
pub event PicturePrintSuccess(pixels: String)
pub event PicturePrintFailure(pixels: String)

  pub struct Canvas {
    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: String

    init(width: UInt8, height: UInt8, pixels: String) {
      self.width = width
      self.height = height
      self.pixels = pixels
    }
  }

  pub resource Picture {
    pub let canvas: Canvas
    
    init(canvas: Canvas) {
      self.canvas = canvas
    }
  }

  pub resource Printer {
    pub let width: UInt8
    pub let height: UInt8
    pub let prints: {String: Canvas}

    init(width: UInt8, height: UInt8) {
      self.width = width;
      self.height = height;
      self.prints = {}
    }

    pub fun print(canvas: Canvas): @Picture? {
      // Canvas needs to fit Printer's dimensions.
      if canvas.pixels.length != Int(self.width * self.height) {
        return nil
      }
      // Canvas can only use visible ASCII characters.
      for symbol in canvas.pixels.utf8 {
        if symbol < 32 || symbol > 126 {
          return nil
        }
      }
      // Printer is only allowed to print unique canvases. W1Q5 events.
      if self.prints.containsKey(canvas.pixels){
        emit PicturePrintFailure(pixels: canvas.pixels)
        return nil
      } else {
        let picture <- create Picture(canvas: canvas)
        self.prints[canvas.pixels] = canvas
        emit PicturePrintSuccess(pixels: canvas.pixels)
        return <- picture
      }
    }
  }

  pub resource Collection {

    pub let pictures: @[Picture] 
    init() { 
      self.pictures <- []
    }

    pub fun deposit(picture: @Picture){
      self.pictures.append(<-picture)
    }
    //part of w1q4 to return the contents of a collection
    pub fun getCanvases(): [Canvas]{
      var canvasesToReturn: [Canvas] = []
      var i = 0
      while i < self.pictures.length{
        canvasesToReturn.append(self.pictures[i].canvas)
        i = i + 1
      }
      return canvasesToReturn
    }
    destroy(){
      destroy self.pictures
    }
    
  }

  pub fun createCollection(): @Collection{
    return <- create Collection()
  }

  init() {
    self.account.save(  
      <- create Printer(width: 5, height: 5),
      to: /storage/ArtistPicturePrinter
    )
    self.account.link<&Printer>(
      /public/ArtistPicturePrinter,
      target: /storage/ArtistPicturePrinter
    )
  }
}
