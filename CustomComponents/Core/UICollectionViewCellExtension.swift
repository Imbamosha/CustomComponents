//
//  UICollectionViewCellExtension.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 26.03.2021.
//

import UIKit

extension UICollectionViewCell {

    open class var identifier: String { return String(describing: self) }

    open class var nibName: String { return String(describing: self) }

    open class var nib: UINib { return UINib(nibName: nibName, bundle: nil) }

}
