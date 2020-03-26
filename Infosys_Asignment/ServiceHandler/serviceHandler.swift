
import Foundation
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
                    var imageArray = [GalleryModel]()
                    let results = try JSONDecoder().decode(ResultModel.self, from: modifiedDataInUTF8Format)
                    for dataArray in results.rows
                    {
                        imageArray.append(GalleryModel(title: dataArray.title ?? "", description: dataArray.description ?? "", imageHref: dataArray.imageHref ?? ""))
                    }
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
}
