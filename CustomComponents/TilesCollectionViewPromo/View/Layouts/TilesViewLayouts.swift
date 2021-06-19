//
//  TilesViewLayouts.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 25.03.2021.
//

import SnapKit

struct TilesViewLayouts {
    
    struct CollectionViewLayouts {
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

