//
//  TileCollectionViewCellLayouts.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 25.03.2021.
//

import SnapKit

struct TileCollectionViewCellLayouts {
    
    struct TitleLabelLayout {
        func initial(_ component: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                
                $0.top.equalToSuperview().offset(41)
                $0.leading.equalToSuperview().offset(18)
                $0.trailing.equalToSuperview().offset(-18)
                
            }
        }
    }
    
    struct ImageViewLayout {
        func initial(_ component: UIView, to title: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(title.snp.bottom).offset(70)
                $0.leading.equalToSuperview().offset(25)
                $0.trailing.equalToSuperview().offset(-25)
                $0.width.equalTo(150)
                $0.height.equalTo(300)
            }
        }
    }
    
    struct DescriptionTitleLabelLayout {
        func initial(_ component: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                
                $0.top.equalToSuperview().offset(41)
                $0.leading.equalToSuperview().offset(18)
                $0.trailing.equalToSuperview().offset(-18)
            }
        }
    }
    
    struct DescriptionLabelLayout {
        func initial(_ component: UIView, to title: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                
                $0.top.equalTo(title.snp.bottom).offset(41)
                $0.leading.equalToSuperview().offset(18)
                $0.trailing.equalToSuperview().offset(-18)
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

