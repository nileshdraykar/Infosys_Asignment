//
//  serviceHandler.swift
//  Infosys_Asignment
//
//  Created by Krawler iMac on 30/01/20.
//  Copyright © 2020 Krawler iMac. All rights reserved.
//

import Foundation
//import Alamofire
//import SwiftyJSON
class serviceHandler : NSObject
{
    
    static let  sharedInstance = serviceHandler()
    func getImageData(completion : @escaping([GalleryModel]?, Error?) -> ())
    {
        let urlStr = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        guard let url = URL(string: urlStr)
        else {
            return
        }
        
        URLSession.shared.dataTask(with: url)
        {
            (data,response, error)in
            if let err = error
            {
                completion(nil,err)
                print("Loading data error : \(err.localizedDescription)")
            }
            else
            {
                guard let data = data else {return}
                
                do
                {
                    let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
                    
                    guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                          print("could not convert data to UTF-8 format")
                          return
                     }
//                    do {
//                        let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
//                        print(responseJSONDict)
//                    } catch {
//                        print(error)
//                    }
                    
                    var imageArray = [GalleryModel]()
                    let results = try JSONDecoder().decode(ResultModel.self, from: modifiedDataInUTF8Format)
                    print(results)
                    
                    for dataArray in results.rows
                    {
                        imageArray.append(GalleryModel(title: dataArray.title ?? "", description: dataArray.description ?? "", imageHref: dataArray.imageHref ?? ""))
                    }
                    print(imageArray)
                    let tempArray = imageArray.compactMap{$0}
                    completion(tempArray, nil)
                }
                catch let jsonErr
                {
                    print("Json error : \(jsonErr)")
                }
            }
        }.resume()
    }
   /*
   func fetchAllRooms(completion: @escaping ([GalleryModel]?) -> Void) {
     guard let url = URL(string: "http://localhost:5984/rooms/_all_docs?include_docs=true") else {
       completion(nil)
       return
     }
     Alamofire.request(url,
                       method: .get,
                       parameters: ["include_docs": "true"])
     .validate()
     .responseJSON { response in
       guard response.result.isSuccess else {
         print("Error while fetching remote rooms: \(String(describing: response.result.error))")
         completion(nil)
         return
       }

       guard let value = response.result.value as? [String: Any],
         let rows = value["rows"] as? [[String: Any]] else {
           print("Malformed data received from fetchAllRooms service")
           completion(nil)
           return
       }

       let rooms = rows.flatMap { roomDict in return RemoteRoom(jsonData: roomDict) }
       completion(rooms)
     }
   }
   */
}
