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
    let letterX <- create Picture(canvas:canvasX)
    display(canvas: letterX.canvas)
    destroy letterX
}