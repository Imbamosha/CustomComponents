//
//  MemoryGameOnboardingViewLayouts.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 26.05.2021.
//

import SnapKit

struct MemoryGameOnboardingViewLayouts {
    
    struct TitleLabelLayout {
        func initial(_ component: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalToSuperview().offset(100)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(50)
            }
        }
    }
    
    struct RulesLabelLayout {
        func initial(_ component: UIView, to title: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(title.snp.bottom).offset(30)
                $0.leading.equalToSuperview().offset(30)
                $0.trailing.equalToSuperview().offset(-30)
                $0.height.equalTo(150)
            }
        }
    }
    
    
    struct CountControlLayout {
        func initial(_ component: UIView, to rules: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(rules.snp.bottom).offset(30)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(50)
                $0.width.equalTo(220)
            }
        }
    }
    
    struct CircularProgressLayout {
        func initial(_ component: UIView, to countControl: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(countControl.snp.bottom).offset(50)
                $0.centerX.equalToSuperview()
                $0.height.width.equalTo(150)
            }
        }
    }
    
    struct LevelDescriptionLabelLayout {
        func initial(_ component: UIView, to circularProgress: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(circularProgress.snp.bottom).offset(30)
                $0.leading.equalToSuperview().offset(30)
                $0.trailing.equalToSuperview().offset(-30)
            }
        }
    }
    
    struct SetupButtonLayout {
        func initial(_ component: UIView, to levelDescription: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(levelDescription.snp.bottom).offset(20)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(50)
                $0.width.equalTo(150)
                $0.bottom.equalToSuperview().offset(-70)
                
            }
        }
    }
    
}
