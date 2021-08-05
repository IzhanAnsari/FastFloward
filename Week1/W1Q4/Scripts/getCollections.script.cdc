/*Test your Collection
    W1Q4 – Connoisseur
        Write a script that prints the contents of collections for all five Playground accounts (0x01, 0x02, etc.). 
        Please use your framed canvas printer function to log each Picture's canvas in a legible way. 
        Provide a log for accounts that don't yet have a Collection.
*/

import Artist from 0x01

pub fun display(canvas: Artist.Canvas){
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

pub fun main(): Int{
    let accounts = [
        getAccount(0x01),
        getAccount(0x02),
        getAccount(0x03),
        getAccount(0x04),
        getAccount(0x05)
    ]

    for account in accounts{
        let collectionRef = account
            .getCapability(/public/ArtistPictureCollection)
            .borrow<&Artist.Collection>()
            //no panic here because it will kill the script once it cant borrow (aka when an account doesnt have a a collection)
        
        if (collectionRef == nil){
            log("GetCollections: ".concat(account.address.toString()).concat(" has no collection made"))
        }
        else{
        let accCanvases = collectionRef!.getCanvases()
            log("GetCollections: ".concat(account.address.toString()).concat(" has a collection of "
                .concat(accCanvases.length.toString()).concat(" canvases.")))
            var y = 0
            while(y < accCanvases.length){ // SAME LOGIC AS DISPLAY FUNCTION
                log("-Canvas ".concat((y+1).toString()).concat(":"))
                display(canvas: accCanvases[y])
/*                log("+-----+")//top of frame
                //in increments of 5 so splice the string in 5 and put frame on both sides
                var fromCounter = 0
                var upToCounter = 5
                while fromCounter < 25 {
                log("|".concat(accCanvases[y].pixels.slice(from: fromCounter, upTo: upToCounter)).concat("|"))
                fromCounter = upToCounter
                upToCounter = upToCounter + 5
                }
                //bottom of frame
                log("+-----+")
*/
                y=y+1
            }
        }
    }

    return 1
}   