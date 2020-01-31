//
//  galleryModel.swift
//  Infosys_Asignment
//
//  Created by Krawler iMac on 30/01/20.
//  Copyright © 2020 Krawler iMac. All rights reserved.
//

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
