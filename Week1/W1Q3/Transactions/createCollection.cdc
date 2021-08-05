import Artist from 0x03

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