//
//  GalleryTableViewController.swift
//  Infosys_Asignment
//
//  Created by Krawler iMac on 30/01/20.
//  Copyright © 2020 Krawler iMac. All rights reserved.
//

import UIKit

class GalleryTableViewController: UIViewController {

    var refreshControl: UIRefreshControl!
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var imageCache = NSCache<NSString, UIImage>()
    @IBOutlet var galleryTableView: UITableView!
    var arrGalleryVM = [GalleryViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        session = URLSession.shared
        task = URLSessionDownloadTask()
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.getData), for: UIControl.Event.valueChanged)
        galleryTableView.addSubview(refreshControl)
    }
    
    @objc func getData()
    {
        serviceHandler.sharedInstance.getImageData{(images, error) in
            if(error == nil)
            {
                
                self.arrGalleryVM = images?.map({return GalleryViewModel(gallery : $0)}) ?? []
                
                DispatchQueue.main.async {
                    self.title = "About Canada"
                    self.galleryTableView.reloadData()
                }
            }
            DispatchQueue.main.async {
                 self.refreshControl.endRefreshing()
            }
        }
    }
}


extension GalleryTableViewController : UITableViewDelegate,UITableViewDataSource
{
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrGalleryVM.count
    }


     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "GalleryTableViewCell", for: indexPath) as! GalleryTableViewCell
        let data = arrGalleryVM[indexPath.row]
        cell.descriptionLbl.text = data.descriptionA
        cell.heading.text =  data.title ?? ""
        
    
        let imageUrl = data.imageHref ?? ""
        if(imageUrl != "")
                {
                    cell.photoImageView.image = #imageLiteral(resourceName: "blankImage")
                    let artworkUrl : String  = imageUrl
                    if let url:URL = URL(string: artworkUrl)
                    {
                        if let cachedImage = self.imageCache.object(forKey: url.absoluteString as NSString)
                        {
                            cell.photoImageView.image =  cachedImage
                        }
                        else
                        {
                            task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                                if let data = try? Data(contentsOf: url){
                                    DispatchQueue.main.async(execute: { () -> Void in
                                        if tableView.cellForRow(at: indexPath) != nil
                                        {
                                            let img:UIImage! = UIImage(data: data)
                                            self.imageCache.setObject(img, forKey: url.absoluteString as NSString)
                                            if ((tableView.indexPathsForVisibleRows?.contains(indexPath))!)
                                            {
                                                cell.photoImageView.image = img
                                                self.galleryTableView.reloadRows(at: [indexPath], with: .automatic)
                                            }
                                        }
                                    })
                                }
                            })
                            task.resume()
                        }
                    }
                }
                else
                {
                    cell.photoImageView.image = #imageLiteral(resourceName: "blankImage")
                }
    
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
   {
        
    }
    
    
    
}
