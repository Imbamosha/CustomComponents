//
//  TabBarView.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 24.03.2021.
//

import UIKit

protocol TabBarViewDelegate: AnyObject {
    
    func tabBarItemDidTouch()
}

class TabBarView: UIView {
    
    private var shapeLayer: CALayer?
    
    var tabBarItems = [CustomTabBarItem]()
    
    private let tabBarItemLayout = TabBarViewLayouts.TabBarItemLayout()
        
    init() {
        super.init(frame: CGRect())
        
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var tintColor: UIColor! {
        didSet {
            for item in tabBarItems {
                item.color = tintColor
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    weak var delegate: TabBarViewDelegate?
    
    var selectedItem: CustomTabBarItem?
}

//MARK: - Interface
extension TabBarView {
    
    func updateView(with items: [CustomTabBarItem]) {
        tabBarItems = items
        
        if tabBarItems.count == 0 { return }
        
        let itemWidth: CGFloat = UIScreen.main.bounds.width / CGFloat(tabBarItems.count)
        
        tabBarItems.forEach {
            addSubview($0)
            tabBarItemLayout.initial($0, index: $0.tag, width: itemWidth, buttonType: $0.getViewModel() ?? .about)
        }
    }
    
    func animateTabBarItems(from fromIndex: Int, to toIndex: Int, normalColor: UIColor, selectedColor: UIColor) {
        if fromIndex != toIndex {
            self.tabBarItems[fromIndex].animateFrom()
            self.tabBarItems[toIndex].animateTo()
        }
    }
    
}

//MARK: - Private func
extension TabBarView {
    
    private func setupViews() {
        backgroundColor = .clear
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        shapeLayer.shadowOffset = CGSize(width:0, height:0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.gray.withAlphaComponent(0.0).cgColor
        shapeLayer.shadowOpacity = 0.3
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let radius: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: (centerWidth - radius * 2), y: 0))
        path.addArc(withCenter: CGPoint(x: centerWidth, y: 0), radius: radius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(0).degreesToRadians, clockwise: false)
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }
    
}

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}
