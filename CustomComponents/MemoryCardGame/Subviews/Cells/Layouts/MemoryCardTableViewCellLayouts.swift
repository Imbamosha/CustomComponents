//
//  MemoryCardTableViewCellLayouts.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 25.05.2021.
//

import UIKit
import SnapKit

struct MemoryCardTableViewCellLayouts {
        
    struct ImageViewLayout {
        func initial(_ component: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalToSuperview().offset(20)
                $0.leading.equalToSuperview().offset(25)
                $0.trailing.equalToSuperview().offset(-25)
                $0.bottom.equalToSuperview().offset(-20)
            }
        }
    }
    
    struct BackgroundImageLayout {
        func initial(_ component: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    func initial(_ component: UIView) {
        guard let _ = component.superview else { return }
        
        component.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
