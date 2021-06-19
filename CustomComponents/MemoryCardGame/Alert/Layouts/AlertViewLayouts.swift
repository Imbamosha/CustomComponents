//
//  AlertViewLayouts.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 29.05.2021.
//

import SnapKit

struct AlertViewLayouts {
    
    struct TitleLabelLayout {
        func initial(_ component: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalToSuperview().offset(35)
                $0.leading.equalToSuperview().offset(15)
                $0.trailing.equalToSuperview().offset(-15)
            }
        }
    }
    
    struct RatingStackLayout {
        func initial(_ component: UIView, to title: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(title.snp.bottom).offset(40)
                $0.leading.equalToSuperview().offset(40)
                $0.trailing.equalToSuperview().offset(-40)
                $0.height.equalTo(70)
            }
        }
    }
    
    struct RecordLabelLayout {
        func initial(_ component: UIView, to rating: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(rating.snp.bottom).offset(40)
                $0.leading.equalToSuperview().offset(20)
                $0.trailing.equalToSuperview().offset(-20)
            }
        }
    }
    
    struct RestartButtonLayout {
        func initial(_ component: UIView, to record: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(record.snp.bottom).offset(30)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(150)
                $0.height.equalTo(50)
            }
        }
    }
    
    struct CloseButtonLayout {
        func initial(_ component: UIView, to restartButton: UIView) {
            guard let _ = component.superview else { return }
            
            component.snp.makeConstraints {
                $0.top.equalTo(restartButton.snp.bottom).offset(30)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(150)
                $0.height.equalTo(50)
                $0.bottom.lessThanOrEqualToSuperview().offset(-20)
            }
        }
    }
    
}
