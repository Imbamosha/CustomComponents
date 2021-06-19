//
//  RatingStackViewLayouts.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 05.04.2021.
//

import SnapKit

struct RatingStackViewLayouts {
    
    struct StarImageViewLayout {
        func initial(_ component: UIView) {
            component.snp.makeConstraints {
                $0.width.height.equalTo(18)
            }
        }
    }
    
}
