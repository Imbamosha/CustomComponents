//
//  MemoryCardGameVCLayouts.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 25.05.2021.
//

import SnapKit

struct MemoryCardGameVCLayouts {
    
    struct CloseButtonLayout {
        func initial(_ component: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.removeConstraints()
            
            component.snp.makeConstraints {
                $0.top.equalToSuperview().offset(50)
                $0.leading.equalToSuperview().offset(30)
                $0.width.height.equalTo(30)
            }
        }
    }
    
    struct OnboardingViewLayout {
        func initial(_ component: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.removeConstraints()
            
            component.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        func hide(_ component: UIView) {
            guard let superview = component.superview else { return }
            
            component.snp.removeConstraints()
            
            component.snp.makeConstraints {
                $0.trailing.leading.equalToSuperview()
                $0.top.equalTo(superview.snp.bottom)
                $0.bottom.equalToSuperview()
            }
        }
        
    }
    
    
    struct StartButtonLayout {
        func initial(_ component: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(20)
                $0.top.equalToSuperview().offset(100)
                $0.height.equalTo(50)
                $0.width.equalTo(130)
            }
        }
    }
    
    struct TimerLabelLayout {
        func initial(_ component: UIView, to button: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
            
                $0.top.equalTo(button.snp.bottom).offset(10)
                $0.leading.equalToSuperview().offset(25)
                $0.height.equalTo(50)
                $0.width.equalTo(50)
            }
        }
    }
    
    struct ResetGameButtonLayout {
        func initial(_ component: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalToSuperview().offset(100)
                $0.trailing.equalToSuperview().offset(-20)
                $0.height.equalTo(50)
                $0.width.equalTo(130)
            }
        }
    }
    
    struct ProgressCircleViewLayout {
        func initial(_ component: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.width.height.equalTo(30)
                $0.top.equalToSuperview().offset(100)
            }
        }
    }
    
    struct CollectionViewLayout {
        func initial(_ component: UIView, to button: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(button.snp.bottom).offset(40)
                $0.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
    
}

