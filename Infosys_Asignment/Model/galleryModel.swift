
import Foundation
class GalleryModel : Decodable
{
    var title : String?
    var description : String?
    var imageHref : String?
    init(title : String, description : String, imageHref : String)
    {
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }
}
class ResultModel : Decodable
{
    var rows = [GalleryModel]()
    init(rows : [GalleryModel])
    {
        self.rows = rows
    }
}
