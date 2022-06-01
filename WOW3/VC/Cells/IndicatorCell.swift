//
//  IndicatorCell.swift
//  WOW3
//
//  Created by Andrei Mosneag on 31.05.2022.
//

import UIKit

class IndicatorCell: UICollectionViewCell {
    
    var inidicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addSubview(inidicator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        inidicator.center = .init(x: self.frame.width / 2,
                                  y: self.frame.height / 2)
    }
    
    func setup() {
       
        
        inidicator.startAnimating()
        
    }

}
