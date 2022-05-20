//
//  ApiService.swift
//  debagJson
//
//  Created by Andrei Mosneag on 11.04.2022.
//

import Foundation
import UIKit

protocol ApiServiceDelegate: AnyObject {
    
}
private var cache = NSCache<NSString, UIImage>()

class ApiService {
    
    static let shared = ApiService()
    
    
    static func downloadImage(withURL url: String, completation: @escaping (_ image: UIImage?)->()) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            var downloadImage: UIImage?
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                if let data = data {
                    downloadImage = UIImage(data: data)
                }
                if downloadImage != nil {
                    cache.setObject(downloadImage!, forKey: url.absoluteString as NSString)
                }else {
                    downloadImage = UIImage(named: "NoImage")
                }
                DispatchQueue.main.async {
                    completation(downloadImage)
                }
            }
        }
        task.resume()
    }
    static func getImage(withURl url: String, completation: @escaping (_ image: UIImage?)->() ){
        guard let urls = URL(string: url) else {return}
        if let image = cache.object(forKey: urls.absoluteString as NSString) {
            completation(image)} else {
                downloadImage(withURL: url, completation: completation)
            }
    }
    

}

