//
//  FavoritesHeaderCell.swift
//  debagJson
//
//  Created by Andrei Mosneag on 28.04.2022.
//

import UIKit

class FavoritesHeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var countFavoritesProducts: UILabel!
    @IBOutlet weak var countView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configHeader()
    }

    func configHeader() {
        countView.layer.cornerRadius = countView.bounds.height / 2
        
    }

    func setup() {
        countFavoritesProducts.text = String(FavoriteManager.shared.countFavorite())
    }
}
