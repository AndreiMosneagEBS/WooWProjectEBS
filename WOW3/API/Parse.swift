//
//  debugAPI.swift
//  debagJson
//
//  Created by Andrei Mosneag on 07.04.2022.
//

import Foundation

class FetchData {

    static let shared = FetchData()
    
    func fetchProducts(pagination: Pagination, onRespons: ((_ response: ProductResponse?) -> ())? = nil ) {
        guard let url = URL(string: "http://mobile-shop-api.hiring.devebs.net/products?page=\(pagination.currentPage)&page_size=\(pagination.perPage)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else {
//                return
//            }
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(ProductResponse.self, from: data)
                    DispatchQueue.main.async {
                        onRespons?(response)
                        
                    }
                } catch let error {
                    print(error)
                    //                didFetchProductFail(error: error.localizedDescription)http://mobile-shop-api.hiring.devebs.net/products?page=\(page)&page_size=5
                }
            }
            
        }.resume()
    }
    }

