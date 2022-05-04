//
//  Identifier+.swift
//  debagJson
//
//  Created by Andrei Mosneag on 11.04.2022.
//

import Foundation
import UIKit

extension UITableViewCell {
    public static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    public static var identifier: String {
        return String(describing: self)
    }
}
