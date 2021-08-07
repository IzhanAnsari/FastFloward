import Artist from "./artist.contract.cdc"

transaction(pixels: String){
    let picture: @Artist.Picture? //name spacing this because in Artist contract. not outside of it
    let collectionRef: &Artist.Collection
    
    prepare(account: AuthAccount){
         let printerRef = getAccount(0x01cf0e2f2f715450)
            .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
            .borrow()
            ?? panic("Couldnt borrow printer bruh :(")

        self.collectionRef = account
            .getCapability(/public/ArtistPictureCollection)
            .borrow<&Artist.Collection>()
            ??panic("Couldnt borrow collection bruh:(")

        let canvas = Artist.Canvas(
            width: printerRef.width,
            height: printerRef.height,
            pixels: pixels
        )

        self.picture <- printerRef.print(canvas: canvas)
    }

    execute{
        if(self.picture == nil) {
            log("PrintTransaction: pic already exists bbgirl")
            destroy self.picture
        }
        else {
            log("PrintTransaction: pic printed")
            self.collectionRef.deposit(picture: <- self.picture!)
        }

        
    }
}