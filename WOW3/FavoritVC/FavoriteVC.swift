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
    
    private var products: [Products] = []
    private var sectionsFavorites: [Sections.Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateAllSectionsFavorites()
        configCollectionView()
    }
    
    private func configCollectionView() {
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.register(UINib(nibName: "FavoritesHeaderCell", bundle: nil), forCellWithReuseIdentifier:"FavoritesHeaderCell")
    }
    
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

//MARK: - UICollectionViewDelegate

extension FavoriteVC: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDataSource

extension FavoriteVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = sectionsFavorites[indexPath.section].cell[indexPath.item]
        switch cellType {
        case .header:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesHeaderCell", for: indexPath) as! FavoritesHeaderCell
            cell.setup()
            return cell
        case .product(model: let model):
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellType = sectionsFavorites[indexPath.section].cell[indexPath.item]
        let width = collectionView.bounds.size.width
        switch cellType {
        case .header:
            return CGSize(width: width, height: 60)
        case .product:
            return CGSize(width: width, height: 220)
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
            //            FavoriteManager.shared.saveToFavorite(id: id)
            generateAllSectionsFavorites()
        }
    }
}
