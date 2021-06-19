//
//  CustomTabBarItemLayouts.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 24.03.2021.
//

import SnapKit

struct CustomTabBarItemLayouts {
    
    struct ImageViewLayout {
        func initial(_ component: UIImageView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalToSuperview().offset(10)
                $0.bottom.equalToSuperview().offset(-10)
                $0.leading.equalToSuperview().offset(10)
                $0.trailing.equalToSuperview().offset(-10)
                $0.center.equalToSuperview()
            }
        }
    }
    
    struct LiquidViewLayout {
        func initialFilledView(_ component: UIView) {
            guard let superview = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.top.equalTo(superview.snp.bottom)
            }
        }
        
        func initialEmptyView(_ component: UIView) {
            guard let superview = component.superview else { return }
            
            component.snp.updateConstraints {
                $0.top.equalTo(superview.snp.top)
            }
        }
    }
   
}
