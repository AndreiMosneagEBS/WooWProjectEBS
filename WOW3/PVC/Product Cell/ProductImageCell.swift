//
//  ProductImageCell.swift
//  debagJson
//
//  Created by Andrei Mosneag on 13.04.2022.
//

import UIKit

class ProductImageCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func getImage(url: String) {
        ApiService.getImage(withURl: url) { image in
            self.productImageView.image = image
        }
    }
}
