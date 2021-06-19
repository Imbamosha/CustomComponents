//
//  UICollectionViewExtension.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 26.03.2021.
//

import UIKit

extension UICollectionView {

    func register(cellTypes: [UICollectionViewCell.Type]) {
        cellTypes.forEach({ self.register($0.nib, forCellWithReuseIdentifier: $0.identifier) })
    }

    func registerWithoutNib(cellTypes: [UICollectionViewCell.Type]) {
        cellTypes.forEach({ self.register($0, forCellWithReuseIdentifier: $0.identifier) })
    }
    
    func register(cellTypes: UICollectionViewCell.Type...) {
        cellTypes.forEach({ self.register($0.nib, forCellWithReuseIdentifier: $0.identifier) })
    }

    func dequeueReusableCell<T: UICollectionViewCell>(withType type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as! T
    }

}
