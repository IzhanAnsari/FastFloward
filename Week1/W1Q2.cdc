// *...*
// .*.*.
// ..*..
// .*.*.
// *...*

//creating a Canvas STRUCTURE
pub struct Canvas{
    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: String

    init(width: UInt8, height: UInt8, pixels: String){
        self.width = width
        self.height = height
        self.pixels = pixels
    }
}

//creating a Picture RESOURCE
pub resource Picture{
    pub let canvas: Canvas //create an instance of a canvas structure

    init(canvas: Canvas){
        self.canvas = canvas;
    }
}



//this will convert an array of string into a string.
//confused about the _ syntax at beginning.
pub fun serializeStringArray(_ lines: [String]): String {
    var buffer = ""
    for line in lines {
        buffer = buffer.concat(line)
    }
    return buffer
}

//W1Q1: displaying the canvas in a frame
pub fun display(canvas: Canvas){
    log("+-----+")//top of frame
    //in increments of 5 so splice the string in 5 and put frame on both sides
    var fromCounter = 0
    var upToCounter = 5
    while fromCounter < 25 {
      log("|".concat(canvas.pixels.slice(from: fromCounter, upTo: upToCounter)).concat("|"))
      fromCounter = upToCounter
      upToCounter = upToCounter + 5
    }
    //bottom of frame
    log("+-----+")

}

//W1Q2
pub resource Printer {
    //create key value pair to keep track of what pics have been printed
    pub let picsPrinted: {String: Bool} 
    //initially nothing has been printed
    init(){
        self.picsPrinted = {}
    }
    //function takes in a canvas and returns its picture resource if it has not been printed
    pub fun print(canvas: Canvas): @Picture?{ // take in type Canvas, return Resource of Picture. Optional tho so can be nil.
        if(self.picsPrinted.containsKey(canvas.pixels)){
            log("sorry buddy ol' pal, no can doooooo")
            return nil
        }
        else {
            self.picsPrinted[canvas.pixels] = true //set to true so we dont print again
            display(canvas: canvas); //from w1q1
            let picToReturn <- create Picture(canvas: canvas); //return the picture resource with this canvas
            return <- picToReturn;
        }
    }
}


pub fun main(){
    //this is an array of strings
    let pixelsX = [
        "*   *",
        " * * ",
        "  *  ",
        " * * ",
        "*   *"
    ]
    let canvasX = Canvas(
        width: 5,
        height: 5,
        pixels: serializeStringArray(pixelsX)
    )

    let printer <- create Printer()
    let printer1 <- printer.print(canvas: canvasX)
    let printer2 <- printer.print(canvas: canvasX)

    destroy printer
    destroy printer1
    destroy printer2
}
 