//
//  ViewController.swift
//  debagJson
//
//  Created by Andrei Mosneag on 06.04.2022.
//
import UIKit
import RealmSwift


class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var footerButton: UIView!
    @IBOutlet weak var countProductFooter: UILabel!
    
    private var sections: [ProductCellType.Sections] = []
    private var cells: [ProductCellType.CellType] = []
    private var porductsDisplayType: HeaderCell.ButtonType = .list
    private var headerTypeCell: HeaderCell.HeaderType = .productFeed
//    private var page: Int = 1
    private var isLoading: Bool = false
    private var pagination: Pagination = Pagination()
    private var isFavorite: Bool = false
    let refreshControl = UIRefreshControl()
    private var products: [Products] = []
    private var sectionsFavorites: [ProductCellType.Sections] = []

    private var isPagination = false
    private var model: ProductResponse?
    private var isHiden: Bool = true
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        setupNavigationBarItem()
        setupFotterButton()
        configureRefreshControl()
        loadProducts(refresh: true)
    }
    
    private func setupNavigationBarItem() {
        if #available(iOS 15, *) {
                    let appearance = UINavigationBarAppearance()
                    appearance.configureWithOpaqueBackground()
                    appearance.backgroundColor = hexStringToUIColor(hex: "#07195C")
                    navigationController?.navigationBar.standardAppearance = appearance;
                    navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
                }
        navigationController?.navigationBar.backgroundColor = hexStringToUIColor(hex: "#07195C")
        let logo = UIImage(named: "Logo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView

    }
    
    func setupFotterButton() {
        footerButton.layer.cornerRadius = footerButton.bounds.height / 2
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HeaderCell", bundle: nil ), forCellWithReuseIdentifier: HeaderCell.identifier)
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.register(UINib(nibName: "ProductCellGread", bundle: nil), forCellWithReuseIdentifier: "ProductCellGread")
        collectionView.register(UINib(nibName: "FavoritesHeaderCell", bundle: nil), forCellWithReuseIdentifier:"FavoritesHeaderCell")
        collectionView.register(UINib(nibName: "IndicatorCell", bundle: nil), forCellWithReuseIdentifier:"LoandingCell")
        
        
    }
    
    private func generateProductsSection(_ article:[Products] ) -> ProductCellType.Sections {
        var newCells: [ProductCellType.CellType] = []
        
        for product in article {
            newCells.append(.product(model: product))
        }
        
        if !pagination.isLastPage {
            newCells.append(.loading)
        
        }
        let prodCell: ProductCellType.Sections = .init(type: .product, cell: newCells)
        
        return prodCell
    }
    
    private func generateHeaderSection() -> ProductCellType.Sections {
        let headerSectionCell:[ProductCellType.CellType] = [.header]
        let headerSection: ProductCellType.Sections = .init(type: .header, cell: headerSectionCell)
        return headerSection
    }
    
    private func generateFavoriteProduct(articles: [Products]) -> ProductCellType.Sections {
        var newCell: [ProductCellType.CellType] = []
        for product in articles {
            if FavoriteManager.shared.checkFavorite(id: product.id){
                newCell.append(.product(model: product))
            }
        }

        let prodCell: ProductCellType.Sections = ProductCellType.Sections(type: .product, cell: newCell)
        return prodCell
    }

    func generateAllSections() {
        let headerSections = generateHeaderSection()
        let productsSections = generateProductsSection(products)
        let favoritesSection = generateFavoriteProduct(articles: products)
        
        var newSection:[ProductCellType.Sections] = []
        newSection.append(headerSections)
        
        if isFavorite {
            newSection.append(favoritesSection)
        }else {
            newSection.append(productsSections)
        }
        
        sections = newSection
        self.collectionView.reloadData()
    }
    
    private var isDescSort: Bool = true {
        willSet {
            if newValue {
                products.sort(by: <)
            } else {
                products.sort(by: >)
            }
        }
    }
    private func configureRefreshControl() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        collectionView.refreshControl = refresh
    }
    
    @objc private func didPullToRefresh() {
        loadProducts(refresh: true)
    }
    
    private func loadProducts(refresh: Bool) {
        if isLoading {
            return
        }
        if refresh{
            pagination = Pagination()
            isLoading = true
        }
        isLoading = true
        
        FetchData.shared.fetchProducts(pagination: pagination) { [weak self] response in
            guard let self = self, let response = response else {
                self?.isLoading = false
                return
            }
            
            if response.pagination.currentPage == 1 {
                self.products = response.results
            } else {
                self.products.append(contentsOf: response.results)
            }
            
            if self.pagination.currentPage >= response.pagination.totalPages {
                self.pagination.isLastPage = true
            } else {
                self.pagination.currentPage += 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                
                if self.collectionView.refreshControl?.isRefreshing == true {
                    self.collectionView.refreshControl?.endRefreshing()
                }
                self.generateAllSections()
                self.isLoading = false
            })
                
        }
    }
    
    @IBAction func favoritesButton(_ sender: Any) {
        let favoritesVC = UIStoryboard(name: "FavoriteVC", bundle: nil).instantiateViewController(withIdentifier:"FavoriteVC")
        self.navigationController?.pushViewController(favoritesVC, animated: true)
        FavoriteManager.shared.getAllFavorites()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if case .product(let model) = sections[indexPath.section].cell[indexPath.row] {
            let storybord = UIStoryboard(name: "Product", bundle: nil)
            guard let vc = storybord.instantiateViewController(withIdentifier: "Product" ) as? ProductViewController else {
                return
            }
            vc.setup(model: model)
            navigationController?.pushViewController(vc, animated: true)
        }
        
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
    
    func generateHiderSection()-> ProductCellType.Sections {
        var headerSectionCell: [ProductCellType.CellType] = []
        headerSectionCell.append(.header)
        let headerSection: ProductCellType.Sections = ProductCellType.Sections(type: .header, cell: headerSectionCell)
        return headerSection
    }
    
    func setup(){
        countProductFooter.text = String(FavoriteManager.shared.countFavorite())
    }
}



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return (self.products.count > 0) ? (self.products.count) : 0
        return sections[section].cell.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if pagination.isLastPage {
                return
            }
            
            let lastItem = self.products.count - 1
            if indexPath.row == lastItem {
                loadProducts(refresh: false)
                
            }
        }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = sections[indexPath.section].cell[indexPath.item]
      
            switch cellType {
            case .header:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.identifier, for: indexPath) as! HeaderCell
                
                cell.onTapSortButton = { [weak self] in
                    guard let self = self else {return}
                    self.isDescSort.toggle()
                    self.generateAllSections()
                }
                
                cell.onTapListView = { [weak self] typeView in
                    self?.porductsDisplayType = typeView
                    self?.generateAllSections()
                }
                
                cell.onTapGridView = { [weak self] typeView in
                    self?.porductsDisplayType = typeView
                    self?.generateAllSections()
                    self?.isHiden.toggle()
                }
                
                return cell
                
            case .product(let product):
                switch porductsDisplayType {
                case .grid:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCellGread", for: indexPath) as! ProductCell
                    cell.setup(model: product)
                    cell.onTapFavoriteButton = { [weak self] model in
                        FavoriteManager.shared.saveToFavorite(product: model)
                        self?.generateAllSections()
                    }
                    return cell
                case .list:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
                    cell.setup(model: product)
                    cell.onTapFavoriteButton = { [weak self] model in
                        FavoriteManager.shared.saveToFavorite(product: model)
                        self?.generateAllSections()
                        
                    }
                    return cell
                }
            case .loading:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoandingCell", for: indexPath) as! IndicatorCell
                    cell.setup()
                return cell
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellType = sections[indexPath.section].cell[indexPath.item]
        let width = collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        switch cellType {
        case .header:
            return CGSize(width: width, height: 60)
        case .product:
            var arcticleWidth: CGFloat
            switch porductsDisplayType {
            case .list:
                arcticleWidth = width
            case .grid:
                arcticleWidth = (width / 2) - 10
            }
            return CGSize(width: arcticleWidth, height: 229)
        case .loading:
            return CGSize(width: width, height: 60)
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
extension ViewController: HeaderCellDelegate {
    
    internal func filterProducts(_ vc: HeaderCell) {
        isDescSort.toggle()
        generateAllSections()
    }
}
    
