//
//  ProductNameCell.swift
//  debagJson
//
//  Created by Andrei Mosneag on 13.04.2022.
//

import UIKit

class ProductInfoCell: UITableViewCell {
    @IBOutlet weak var nameLableOutlet: UILabel!
    @IBOutlet weak var descriptionProductOutlet: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var sellPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    struct Params {
        var name: String?
        var description: String?
        var price: String?
        var sellPrice: String?
    }
    
    func setup(param: Params) {
        self.nameLableOutlet.text = param.name
        self.descriptionProductOutlet.text = param.description
        self.price.text = param.price
        self.sellPrice.text = param.sellPrice
    }
    
}
