//
//  TabBarItemModel.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 24.03.2021.
//

import UIKit

enum TabBarItemModel: String, CaseIterable {
    case menu = "Меню"
    case profile = "Профиль"
    case cart = "Корзина"
    case about = "О компании"
    case extra = "Кнопка"
}

extension TabBarItemModel {
    
    var viewController: UIViewController {
        switch self {
        case .about:
            return UIViewController()
        case .cart:
            return UIViewController()
        case .menu:
            return UIViewController()
        case .profile:
            return UIViewController()
        case .extra:
            return UIViewController()
        }
    }
    
    var icon: UIImage {
        switch self {
        case .about:
            return UIImage(named: "bb_tabCategory")!
        case .cart:
            return UIImage(named: "bb_tabCart")!
        case .menu:
            return UIImage(named: "bb_tabMenu")!
        case .profile:
            return UIImage(named: "bb_tabCoffee")!
        case .extra:
            return UIImage(named: "bb_tabQR")!
        }
    }
    
    var lock: Bool {
        switch self {
        case .extra:
            return true
        default:
            return false
        }
    }
    
    var isSelected: Bool {
        switch self {
        default:
            return false
        }
    }
    
}
