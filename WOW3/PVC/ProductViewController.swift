//
//  ProductViewController.swift
//  debagJson
//
//  Created by Andrei Mosneag on 13.04.2022.
//

import UIKit

class ProductViewController: UIViewController, UICollectionViewDelegate{
    var products:[Products] = []
    var model: Products?
    var cells: [ProductsInfoCellType] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        generateProductSection()
    }
    
     func setup(model: Products) {
        self.model = model
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProductImageCell", bundle: nil), forCellReuseIdentifier: ProductImageCell.identifier)
        tableView.register(UINib(nibName: "ProductInfoCell", bundle: nil), forCellReuseIdentifier: ProductInfoCell.identifier)
        tableView.register(UINib(nibName: "ProductInformationCell", bundle: nil), forCellReuseIdentifier: ProductInformationCell.identifier)
        
    }
    
        private func generateProductSection() {
        var newCell: [ProductsInfoCellType] = []
        newCell.append(.image)
        newCell.append(.name)
        newCell.append(.descriptio)
        self.cells = newCell
        tableView.reloadData()
    }
}

extension ProductViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cells[indexPath.row] {
        case .image:
            let imageCell = tableView.dequeueReusableCell(withIdentifier: ProductImageCell.identifier, for: indexPath) as! ProductImageCell
            imageCell.getImage(url: model?.category.icon ?? "")
            return imageCell
        case .name:
            let nameCell = tableView.dequeueReusableCell(withIdentifier: ProductInfoCell.identifier, for: indexPath) as! ProductInfoCell
            let params: ProductInfoCell.Params = .init(name: model?.name,
                                                       description: model?.details,
                                                       price: "\(model?.price ?? 0)",
                                                       sellPrice: "0")
            nameCell.setup(param: params)
            return nameCell
        case .descriptio:
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: ProductInformationCell.identifier, for: indexPath) as! ProductInformationCell
            descriptionCell.setup(details: model?.details ?? "")
            return descriptionCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cells[indexPath.row] {
            
        case .image:
            return 300
        case .name:
            return 140
        case .descriptio:
            return UITableView.automaticDimension
        }
    }
}
extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}





