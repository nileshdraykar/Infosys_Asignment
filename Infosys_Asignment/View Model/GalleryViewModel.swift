

import UIKit
class GalleryViewModel: NSObject
{
    var title : String?
    var descriptionA : String?
    var imageHref : String?
    init(gallery : GalleryModel) {
        self.title = gallery.title
        self.descriptionA = gallery.description
        self.imageHref = gallery.imageHref
    }
}
