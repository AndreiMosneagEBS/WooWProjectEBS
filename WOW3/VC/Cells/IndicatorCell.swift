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
    
    func setup() {
        contentView.addSubview(inidicator)
        inidicator.center = .init(x: contentView.frame.height / 2,
                                  y: contentView.frame.width / 2)
        inidicator.startAnimating()
        
    }

}
