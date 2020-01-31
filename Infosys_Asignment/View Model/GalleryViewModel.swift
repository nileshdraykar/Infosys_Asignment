//
//  GalleryViewModel.swift
//  Infosys_Asignment
//
//  Created by Krawler iMac on 30/01/20.
//  Copyright © 2020 Krawler iMac. All rights reserved.
//

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
