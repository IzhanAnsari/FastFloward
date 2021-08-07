import Artist from "./artist.contract.cdc"

transaction{
    prepare(account: AuthAccount){
        let collection <- Artist.createCollection()
        account.save(
            <- collection,
            to: /storage/ArtistPictureCollection
        )
        account.link<&Artist.Collection>(
            /public/ArtistPictureCollection,
            target: /storage/ArtistPictureCollection
        )
    }
}