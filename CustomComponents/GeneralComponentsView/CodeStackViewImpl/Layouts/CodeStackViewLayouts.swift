//
//  CodeStackViewLayouts.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 11.04.2021.
//

import SnapKit

struct PhoneCodeViewLayouts {
    
    struct StackViewLayouts {
        func initial(_ component: UIView, to button: UIButton) {
            guard let _  = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.leading.top.bottom.equalToSuperview()
                $0.trailing.equalTo(button.snp.leading)
            }
        }
    }
    
    struct StackViewSubview {
        func initial(_ component: UIView) {
            guard let _  = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.width.height.equalTo(50)
            }
        }
    }
    
    
    struct ButtonLayouts {
        func initial(_ component: UIView) {
            guard let _  = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.trailing.top.bottom.equalToSuperview()
                $0.width.height.equalTo(50)
            }
        }
    }
}

