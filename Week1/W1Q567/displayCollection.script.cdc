/*Test your Collection
    W1Q7 – What you got?
        Implement the displayCollection.script.cdc as per the specification in the file.
*/

import Artist from "./artist.contract.cdc"


pub fun main(address: Address): [String]? {
    let account = getAccount(address)

    let collectionRef = account
        .getCapability(/public/ArtistPictureCollection)
        .borrow<&Artist.Collection>()
    
    if (collectionRef == nil){
        log(address.toString().concat(" has no collection made"))
        return nil
    }
    else{
        var pixelStringsToReturn: [String] = []
        let accCanvases = collectionRef!.getCanvases()
        for canvas in accCanvases{
            pixelStringsToReturn.append(canvas.pixels)
        }
    /*  THIS DOES THE SAME THING. JUST MESSIER. OTHER METHOD IS MUCH NEATER. 
        var y = 0
        while(y < accCanvases.length){
            pixelStringsToReturn.append(accCanvases[y].pixels)
            y=y+1
        }
    */
        return pixelStringsToReturn
    }
}