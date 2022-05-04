//
//  FavoriteVC.swift
//  debagJson
//
//  Created by Andrei Mosneag on 18.04.2022.
//

import UIKit
import RealmSwift

class FavoriteVC: UIViewController {
    
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private var products: [Products] = []
    private var sectionsFavorites: [Sections.Section] = []
    
    
    
    private func generateCartProduct(articles: [Products]) -> Sections.Section {
        var newcell: [Sections.CellType] = []
        for product in articles {
            if CartManager.shared.checkCart(id: product.id) {
                newcell.append(. product(model: product))
            }
        }
        let prodcutCell: Sections.Section = Sections.Section(type: .product , cell: newcell )
        return prodcutCell
    }
    
    func generateHiderSection()-> Sections.Section {
        var headerSectionCell: [Sections.CellType] = []
        headerSectionCell.append(.header)
        let headerSection: Sections.Section = Sections.Section(type: .header, cell: headerSectionCell)
        return headerSection
    }
    
    func generateAllSectionsFavorites() {
        let hiderSection = generateHiderSection()
        let productCardSection = generateCartProduct(articles: products)
        var newSection: [Sections.Section] = []
        newSection.append(hiderSection)
        newSection.append(productCardSection)
        sectionsFavorites = newSection
        
        DispatchQueue.main.async {
            self.favoritesCollectionView.reloadData()
        }
    }

}

extension FavoriteVC: ProductCellDelegate {
    func pressButton(_ vc: ProductCell, button: ProductCell.ButtonType) {
        switch button {
        case .addToCart(let id):
            CartManager.shared.saveToCart(id: id)
            generateAllSectionsFavorites()
        case .addToFavorite(let id):
            FavoriteManager.shared.saveToFavorite(id: id)
            generateAllSectionsFavorites()
        }
    }
}
