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
    
    private var products: [Favorite] = []
    private var sectionsFavorites: [FavoriteSections.Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.products = FavoriteManager.shared.getAllFavorites()
        generateAllSectionsFavorites()
        configCollectionView()
    }
    
    private func configCollectionView() {
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.register(UINib(nibName: "FavoritesHeaderCell", bundle: nil), forCellWithReuseIdentifier:"FavoritesHeaderCell")
        favoritesCollectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        
    }
    
    private func generateFavoriteProducts(articles: [Favorite]) -> FavoriteSections.Section {
        var newcell: [FavoriteSections.CellType] = articles.map { favorites in
            return FavoriteSections.CellType.favorites(model: favorites)
        }
        let prodcutCell: FavoriteSections.Section = FavoriteSections.Section(type: .product , cell: newcell)
        return prodcutCell
    }
    
    func generateHiderSection()-> FavoriteSections.Section {
        var headerSectionCell: [FavoriteSections.CellType] = []
        headerSectionCell.append(.header)
        let headerSection: FavoriteSections.Section = FavoriteSections.Section(type: .header, cell: headerSectionCell)
        return headerSection
    }
    
    func generateAllSectionsFavorites() {
        let hiderSection = generateHiderSection()
        let productCardSection = generateFavoriteProducts(articles: products)
        var newSection: [FavoriteSections.Section] = []
        newSection.append(hiderSection)
        newSection.append(productCardSection)
        sectionsFavorites = newSection
        
        DispatchQueue.main.async {
            self.favoritesCollectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource

extension FavoriteVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsFavorites[section].cell.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsFavorites.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = sectionsFavorites[indexPath.section].cell[indexPath.item]
        switch cellType {
        case .header:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesHeaderCell", for: indexPath) as! FavoritesHeaderCell
            cell.setup()
            return cell
        case .favorites(let model):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            cell.favorites(model: model)
            
            cell.onTapFavoriteButton =  { [weak self] typeButton in
                switch typeButton {
                case .addToCart(id: let id):
                    break
                case .addToFavorite(model: let model):
                    if FavoriteManager.shared.checkFavorite(id: model.id) {
                        try! FavoriteManager.shared.delete(id: model.id)
                    }
                    self?.generateAllSectionsFavorites()
                }
            }
            return cell
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellType = sectionsFavorites[indexPath.section].cell[indexPath.item]
        let width = collectionView.bounds.size.width
        switch cellType {
        case .header:
            return CGSize(width: width, height: 60)
        case .favorites:
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
            FavoriteManager.shared.saveToFavorite(product: id)
            generateAllSectionsFavorites()
        }
    }
}
