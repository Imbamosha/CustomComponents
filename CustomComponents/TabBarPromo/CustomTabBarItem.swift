//
//  CustomTabBarItem.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 24.03.2021.
//

import UIKit

class CustomTabBarItem: UIButton {
    
    //MARK: - UIComponents
    private weak var liquidView: UIView!
    private weak var iconImageView: UIImageView!
    
    var color: UIColor = UIColor.lightGray { didSet {
       
        //iconImageView.tintColor = color
    }}
    
    //MARK: - ViewModel
    private var tabBarViewModel: TabBarItemModel?
    
    init(viewModel: TabBarItemModel) {
        super.init(frame: CGRect())
        translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: - Setup
        tabBarViewModel = viewModel
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.frame = CGRect(x: 8.5, y: 8, width: self.bounds.width - 17, height: self.bounds.height - 17)
    }
    
}

//MARK: - Interface
extension CustomTabBarItem {
    
    //func animate
    func getViewModel() -> TabBarItemModel? {
        return tabBarViewModel
    }
    
    func animateFrom() {
        if tabBarViewModel != .extra {
            if liquidView != nil {
                UIView.animate(withDuration: 1) {
                    self.liquidView.frame.origin.y = self.bounds.height
                } completion: { _ in
                    self.liquidView.removeFromSuperview()
                }
            }
        }
    }
    
    func animateTo() {
        guard let viewModel = tabBarViewModel else { return }
        
        if viewModel != .extra {
            let liquidBackground = UIView()
            liquidBackground.frame = CGRect(x: 5, y: 5, width: self.bounds.width - 10, height: self.bounds.height - 10)
            liquidBackground.backgroundColor = .red
            liquidView = liquidBackground
            
            self.addSubview(liquidView)
            
            reset()
            UIView.animate(withDuration: 1) {
                self.liquidView.frame.origin.y = 0
            }
        }
    }
    
}
//MARK: - Private methods
extension CustomTabBarItem {
    
    private func setupSubviews() {
        setupViews()
    }
    
    private func setupViews() {
        guard let viewModel = tabBarViewModel else { return }
        
        if viewModel.lock {
            let iconImage = UIImageView()
            iconImage.contentMode = .scaleAspectFit
            iconImage.image = viewModel.icon
            iconImageView = iconImage
            
            addSubview(iconImageView)
        } else {
            self.backgroundColor = .darkGray
            
            let iconImage = UIImageView()
            iconImage.contentMode = .scaleAspectFit
            iconImage.image = viewModel.icon
            iconImageView = iconImage
            
            self.mask = iconImage
            
            layoutIfNeeded()
            reset()
        }
    }
    
    private func reset() {
        if liquidView != nil {
            liquidView.frame.origin.y = bounds.height
        }
    }
}
