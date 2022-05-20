//
//  headerCell.swift
//  debagJson
//
//  Created by Andrei Mosneag on 08.04.2022.
//

import UIKit
protocol HeaderCellDelegate: AnyObject {
    func filterProducts(_ vc: HeaderCell)
}


class HeaderCell: UICollectionViewCell {
    @IBOutlet weak var filtersButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    
//    var delegate: HeaderCellDelegate?
    var onTapSortButton: (()-> Void)?
    var onTapGridView: ((_ type: ButtonType)-> Void)?
    var onTapListView: ((_ type: ButtonType)-> Void)?

    @IBOutlet weak var gridButton: UIButton!
    
    enum ButtonType {
        case grid
        case list
    }
    enum HeaderType {
        case isFavorite
        case productFeed
    }
    
    private func changeIcon(type: ButtonType) {
        switch type {
        case .grid:
            listButton.backgroundColor = UIColor(named: "darkGray")
            listButton.tintColor = UIColor(named: "darkBlue")
            
            gridButton.backgroundColor = UIColor(named: "darkBlue")
            gridButton.tintColor = UIColor(named: "darkGray")
        case .list:
            gridButton.backgroundColor = UIColor(named: "darkGray")
            gridButton.tintColor = UIColor(named: "darkBlue")
            
            listButton.backgroundColor = UIColor(named: "darkBlue")
            listButton.tintColor = UIColor(named: "darkGray")
        }
    }

    override internal func awakeFromNib() {
        super.awakeFromNib()
        self.listButton.backgroundColor = UIColor(named: "darkBlue")
        self.gridButton.backgroundColor = UIColor(named: "darkGray")

    }
    
    @IBAction private func filter(_ sender: Any) {
//        delegate?.filterProducts(self)
        self.onTapSortButton?()
    }
    
    @IBAction func changeToGrid(_ sender: Any) {
        self.onTapGridView?(.grid)
        changeIcon(type: .grid)
    }
    
    @IBAction func changeToList(_ sender: Any) {
        self.onTapListView?(.list)
        changeIcon(type: .list)

    }

}
extension UIButton{

    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }

}
