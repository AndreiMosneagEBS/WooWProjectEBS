import Foundation

struct ProductResponse: Decodable {
    

    var results: [Products]
    var pagination: Pagination?
    
    private enum ArticleCodingKeys: String, CodingKey {
        case count
        case totalPages = "total_pages"
        case perPage = "per_page"
        case currentPage = "current_page"
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ArticleCodingKeys.self)
        pagination?.count = try container.decode(Int.self, forKey: .count)
        pagination?.totalPages = try container.decode(Int.self, forKey: .totalPages)
        pagination?.perPage = try container.decode(Int.self, forKey: .perPage)
        pagination?.currentPage = try container.decode(Int.self, forKey: .currentPage)
        
        self.results = try container.decode([Products].self, forKey: .results)
    }
    
}

struct Products: Decodable {
    var category: Category
    var name: String
    var details: String
    var size: String?
    var colour: String?
    var price: Int
    var id: Int
    
    private enum  ProductsCodingKeys: String, CodingKey {
        case category
        case name
        case details
        case size
        case colour
        case price
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductsCodingKeys.self)
        self.category = try container.decode(Category.self, forKey: .category)
        self.name = try container.decode(String.self, forKey: .name)
        self.details = try container.decode(String.self, forKey: .details)
        self.size = try container.decode(String.self, forKey: .size)
        self.colour = try container.decode(String.self, forKey: .colour)
        self.price = try container.decode(Int.self, forKey: .price)
        self.id = try container.decode(Int.self, forKey: .id)
    }
    }

extension Products: Equatable, Comparable {
    static func < (lhs: Products, rhs: Products) -> Bool {
        return lhs.price < rhs.price
    }
    
    static func == (lhs: Products, rhs: Products) -> Bool {
        return lhs.id == rhs.id
    }
}
