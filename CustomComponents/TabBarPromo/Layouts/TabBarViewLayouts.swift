//
//  TabBarViewLayouts.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 24.03.2021.
//

import SnapKit

struct TabBarViewLayouts {
    
    struct TabBarItemLayout {
        func initial(_ component: UIView, index: Int, width: CGFloat, buttonType: TabBarItemModel) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                if buttonType == .extra {
                    $0.width.height.equalTo(85)
                    $0.centerX.equalToSuperview()
                } else {
                    $0.top.equalToSuperview()
                    $0.width.height.equalTo(width)
                    $0.leading.equalToSuperview().offset(CGFloat(index) * width)
                    $0.trailing.lessThanOrEqualToSuperview().priority(750)
                }
                $0.bottom.equalToSuperview().offset(buttonType == .extra ? -18 : 0)
            }
        }
    }
    
    func initial(_ component: UIView, height: CGFloat) {
        guard let _ = component.superview else { return }
        
        component.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(height)
        }
    }
    
}
