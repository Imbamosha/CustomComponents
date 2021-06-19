//
//  TabBarController.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 24.03.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    private var customTabBar: TabBarView!
   
    private let customTabBarLayouts = TabBarViewLayouts()
    
    var normalColor = UIColor.lightGray {
        didSet {
            customTabBar.tintColor = normalColor
        }
    }
    
    var selectedColor = UIColor.red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - Скрываем дефолтный таббар
        tabBar.isHidden = true
        setupTabBar()
        
        customTabBar.updateView(with: tabBarItems)
    }
    
    private var tabBarItems = [CustomTabBarItem]()
    
    init(items: [CustomTabBarItem]) {
        tabBarItems = items
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TabBarController {
    
    private func setupTabBar() {
        let customBar = TabBarView()
        customBar.tintColor = normalColor
        self.customTabBar = customBar
        
        view.addSubview(self.customTabBar)
        
        customTabBarLayouts.initial(self.customTabBar, height: 60)
        
        for i in 0 ..< tabBarItems.count {
            tabBarItems[i].tag = i
            tabBarItems[i].addTarget(self, action: #selector(switchTab), for: .touchUpInside)
        }
        
        setupTabController()
    }
    
    private func setupTabController() {
        let red = UIViewController()
        red.view.backgroundColor = .white
        let green = UIViewController()
        green.view.backgroundColor = UIColor(red: 172/255, green: 236/255, blue: 213/255, alpha: 1.0)
        let blue = UIViewController()
        blue.view.backgroundColor = UIColor(red: 255/255, green: 249/255, blue: 170/255, alpha: 1.0)
        let yellow = UIViewController()
        yellow.view.backgroundColor = UIColor(red: 255/255, green: 213/255, blue: 184/255, alpha: 1.0)
        let gray = UIViewController()
        gray.view.backgroundColor = UIColor(red: 255/255, green: 185/255, blue: 179/255, alpha: 1.0)
        
        viewControllers = [red, green, blue, yellow, gray]
    }
    
    @objc func switchTab(button: UIButton) {
        changeTab(from: selectedIndex, to: button.tag)
        selectedIndex = button.tag
    }
    
    private func changeTab(from fromIndex: Int, to toIndex: Int) {
        customTabBar.animateTabBarItems(from: fromIndex, to: toIndex, normalColor: normalColor, selectedColor: selectedColor)
    }
    
}
