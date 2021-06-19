//
//  AlertContainerViewLayouts.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 29.05.2021.
//

import SnapKit

struct AlertContainerViewLayouts {
    
    struct AlertLayouts {
        func initial(_ component: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
                $0.width.equalTo(350)
                $0.height.equalTo(500)
            }
        }
    }
    
    struct BackgroundViewLayouts {
        func initial(_ component: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
}
