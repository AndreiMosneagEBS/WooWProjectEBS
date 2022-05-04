//
//  ProductCell.swift
//  debagJson
//
//  Created by Andrei Mosneag on 08.04.2022.
//

import UIKit
protocol ProductCellDelegate : AnyObject {
    func pressButton (_ vc: ProductCell, button: ProductCell.ButtonType)
}

class ProductCell: UICollectionViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet private weak var salePrice: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    
    var onTapFavoriteButton: ((_ button: ProductCell.ButtonType) -> Void)?
    
    private var model: Products?
    weak var delegate: ProductCellDelegate?
    
    enum ButtonType {
        case addToCart(id: Int)
        case addToFavorite(id: Int)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetView()
    }

    @IBAction private func favoritesActionButton(_ sender: Any) {
        guard let model = model else {
            return
        }
        self.onTapFavoriteButton?(.addToFavorite(id: model.id))
    }
    
    struct Params {
        var name: String?
        var description: String?
        var price: Int
        var salePrice: Int
        var image: String?
        var model: Products?
    }
    
    func setup(model: Products) {
        self.model = model
        nameLabel.text = model.name
        descriptionLabel.text = model.details
        price.text = "\(model.price)"
        getImage(url: model.category.icon ?? "")
        
        let icon = FavoriteManager.shared.checkFavorite(id: model.id) ? "fillHeart" : "heart"
        let image = UIImage(named: icon)
        favoritesButton.setImage(image, for: .normal)
    }
    
    private func getImage(url: String) {
        ApiService.getImage(withURl: url ) { [weak self] image in
            self?.productImage.image = image
        }
    }
    
    private func resetView() {
        favoritesButton.setImage(nil, for: .normal)
    }
}