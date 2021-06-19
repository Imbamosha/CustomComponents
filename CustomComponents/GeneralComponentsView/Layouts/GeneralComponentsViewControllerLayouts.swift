//
//  GeneralComponentsViewControllerLayouts.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 27.03.2021.
//

import SnapKit

struct GeneralComponentsViewControllerLayouts {
    
    struct CircularProgressViewLayout {
        
        func initial(_ component: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(120)
                $0.height.width.equalTo(150)
            }
        }
        
    }
    
    struct CountControlViewLayout {
        
        func initial(_ component: UIView, to progress: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(progress.snp.bottom).offset(30)
                $0.height.equalTo(50)
                $0.width.equalTo(150)
            }
        }
    }
    
    struct SeparatorViewLayout {
        
        func initial(_ component: UIView, to view: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(view.snp.bottom).offset(20)
                $0.height.equalTo(1.5)
                $0.leading.trailing.equalToSuperview()
            }
        }
    }
    
    struct CodeStackViewLayout {
        
        func initial(_ component: UIView, to countControl: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(countControl.snp.bottom).offset(50)
                $0.height.equalTo(50)
                $0.leading.equalToSuperview().offset(30)
                $0.trailing.equalToSuperview().offset(-30)
            }
        }
    }
    
    struct RatingStackViewLayout {
        
        func initial(_ component: UIView, to view: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(view.snp.bottom).offset(50)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(250)
            }
        }
    }
    
    struct RatingSetupTextFieldLayout {
        
        func initial(_ component: UIView, to view: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(view.snp.bottom).offset(30)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(180)
                $0.height.equalTo(52)
            }
        }
    }
    
    struct RatingSetupButtonLayout {
        func initial(_ component: UIView, to view: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(view.snp.bottom).offset(20)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(150)
                $0.height.equalTo(52)
            }
        }
        
    }
}
