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
//extension ApiService {
//    
//    func fetchProducts(pagination: Pagination, onResponse: ((_ response: ProductResponse?) -> Void)? = nil) {
//        guard let url = URL(string: "http://mobile-shop-api.hiring.devebs.net/products?page=\(pagination.currentPage)&page_size=\(pagination.perPage)") else {
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else {
//                return
//            }
//            
//            do {
//                let response = try JSONDecoder().decode(ProductResponse.self, from: data)
//                DispatchQueue.main.async {
//                    onResponse?(response)
//                }
//            } catch let error {
//                print(error)
////                didFetchProductFail(error: error.localizedDescription)
//                DispatchQueue.main.async {
//                    onResponse?(nil)
//                }
//            }
//        }.resume()
//    }
//    
//}

