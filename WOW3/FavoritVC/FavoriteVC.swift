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
    var realm: Realm {
        try! Realm()
    }
    private var products: [Products] = []
    private var sectionsFavorites: [FavoriteSections.Section] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.products = FavoriteManager.shared.getAllFavorites()
        generateAllSectionsFavorites()
        configCollectionView()
//        setupNavigationBarItem()
//        addBackbutton ()
    }
    //    MARK: - CONFIGURATION
    
//    private func setupNavigationBarItem() {
//        var imageBack = UIImage (named: "Arrow")
//        imageBack = imageBack?.withRenderingMode(.alwaysOriginal)
//        var imageFavorite = UIImage (named: "IconHeartFull")
//        imageFavorite = imageFavorite?.withRenderingMode(.alwaysOriginal)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem ( image: imageFavorite, style: .done, target: nil, action: nil)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem ( image: imageBack, style: .plain, target: nil, action: #selector(UINavigationController.popViewController(animated:)))
//        
//
//    }

    
    private func configCollectionView() {
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.register(UINib(nibName: "FavoritesHeaderCell", bundle: nil), forCellWithReuseIdentifier:"FavoritesHeaderCell")
        favoritesCollectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        
    }
        
    private func generateFavoriteProducts(articles: [Products]) -> FavoriteSections.Section {
        let newcell: [FavoriteSections.CellType] = articles.map { favorites in
            return FavoriteSections.CellType.favorites(model: favorites)
        }
        let prodcutCell: FavoriteSections.Section = FavoriteSections.Section(type: .product , cell: newcell)
        return prodcutCell
    }
    
    
    @IBAction func backButtonFavorites(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    
//    func addBackbutton () {
//
//        let backButton = UIButton (type: .custom)
//        backButton.setImage(UIImage(named: "Arrow"), for: .normal)
//        backButton.setTitleColor(.blue, for: .normal)
//        backButton.frame = CGRect (x: 0, y: 0, width: 30, height: 50)
//        backButton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
//        let view = UIView (frame: CGRect(x: 0, y: 0, width: 80, height: 80))
////        view.bounds = view.bounds.offsetBy(dx: 0, dy: -2)
//        view.addSubview(backButton)
//        let backButtonView = UIBarButtonItem(customView: view )
//
//        navigationItem.leftBarButtonItem = backButtonView
//
//        navigationItem.rightBarButtonItem = .init(customView: view)
//    }
//    @objc func backAction () {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    
    
    func generateHiderSection()-> FavoriteSections.Section {
        var headerSectionCell: [FavoriteSections.CellType] = []
        headerSectionCell.append(.header)
        let headerSection: FavoriteSections.Section = FavoriteSections.Section(type: .header, cell: headerSectionCell)
        return headerSection
    }
    
    func generateAllSectionsFavorites() {
        self.products = FavoriteManager.shared.getAllFavorites()
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
            cell.setup(model: model)
            
            cell.onTapFavoriteButton =  { [weak self] model in
                FavoriteManager.shared.saveToFavorite(product: model)
                self?.generateAllSectionsFavorites()
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
        case .addToCart(_):
            generateAllSectionsFavorites()
        case .addToFavorite(let product):
            FavoriteManager.shared.saveToFavorite(product: product)
            generateAllSectionsFavorites()
        }
    }
}
