import Foundation
import RealmSwift
struct ProductResponse: Decodable {
    

    var results: [Products]
    var pagination: Pagination
    
    private enum ArticleCodingKeys: String, CodingKey {
        case count
        case totalPages = "total_pages"
        case perPage = "per_page"
        case currentPage = "current_page"
        case results
    }
    

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ArticleCodingKeys.self)
        let count = try container.decode(Int.self, forKey: .count)
        let totalPages = try container.decode(Int.self, forKey: .totalPages)
        let perPage = try container.decode(Int.self, forKey: .perPage)
        let currentPage = try container.decode(Int.self, forKey: .currentPage)
        self.results = try container.decode([Products].self, forKey: .results)
        self.pagination = Pagination(count: count, totalPages: totalPages, perPage: perPage, currentPage: currentPage)
    }
}

class Products: Object, Codable {
    
    convenience init(id: Int, name: String, details: String, price: Int, main_image: String) {
        self.init()
        self.id = id
        self.name = name
        self.details = details
        self.price = price
        self.main_image = main_image
    }
    
    @Persisted(primaryKey: true)
    @objc dynamic var id: Int
    @Persisted var name: String = ""
    @Persisted var details: String = ""
    @Persisted var price: Int = 0
    @Persisted var main_image: String = ""
    
    }

struct Pagination {
    var count: Int = 0
    var totalPages: Int = 0
    var perPage: Int = 5
    var currentPage: Int = 1
    var isLastPage: Bool = false
}


extension Products: Comparable {
    static func < (lhs: Products, rhs: Products) -> Bool {
        return lhs.price < rhs.price
    }
    
    static func == (lhs: Products, rhs: Products) -> Bool {
        return lhs.id == rhs.id
    }
}
