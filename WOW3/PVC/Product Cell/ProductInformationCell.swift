//
//  ProductInformationCell.swift
//  debagJson
//
//  Created by Andrei Mosneag on 13.04.2022.
//

import UIKit

class ProductInformationCell: UITableViewCell {
    
    @IBOutlet weak var descriptionOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetView()
    }
    
    private func resetView() {
        descriptionOutlet.text = nil
    }
    
    func setup(details: String) {
        self.descriptionOutlet.text = details
    }
    
}
