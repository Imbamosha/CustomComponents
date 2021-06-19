//
//  StarRatingView.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 07.04.2021.
//

import UIKit

open class StarRatingView: UIView {
    
    struct Customization {
        let fillImage: UIImage
        let halfImage: UIImage
        let emptyImage: UIImage
        let spacing: CGFloat
        let fillTintColor: UIColor
        let maximumValue: Int
    }
    
    private var starStack: UIStackView!
    private let customization: Customization!
    
    @Clamping(initialValue: 0.0, range: 0...5) var value: Double { didSet {
        updateSubviews()
    }}
    
    open var spacing: CGFloat {
        get { return starStack.spacing }
        set { starStack.spacing = newValue }
    }
    
    init(customization: StarRatingView.Customization) {
        self.customization = customization
        super.init(frame: CGRect.zero)
        setupSubviews()
        updateSubviews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StarRatingView {
    
    private func setupSubviews() {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = customization.spacing
        self.starStack = stackView
        
        addSubview(starStack)
        starStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        starStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        starStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        starStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        setNeedsLayout()
    }

    private func updateSubviews() {
        recountingStars()
        updateStars()
        setNeedsLayout()
    }

    private func recountingStars() {
        let oldCount = starStack.arrangedSubviews.count
        let newCount = customization.maximumValue
        
        guard oldCount != newCount else { return }
        
        if oldCount > newCount {
            starStack.arrangedSubviews[newCount..<oldCount].forEach { $0.removeFromSuperview() }
        } else {
            let starWidth = starStack.frame.width / CGFloat(customization.maximumValue)
            for _ in oldCount..<newCount {
                let star = UIImageView()
                star.translatesAutoresizingMaskIntoConstraints = false
                starStack.addArrangedSubview(star)
                star.heightAnchor.constraint(equalTo: star.widthAnchor).isActive = true
                star.widthAnchor.constraint(equalToConstant: starWidth).isActive = true
            }
        }
    }
    
    private func updateStars() {
        var computedValue = self.value
        starStack.arrangedSubviews
            .compactMap { $0 as? UIImageView }
            .enumerated()
            .forEach {
                (index, star) in
                if computedValue >= 1.0 {
                    star.image = customization.fillImage
                    computedValue -= 1.0
                    star.tintColor = customization.fillTintColor
                } else if computedValue < 1.0 && computedValue >= 0.5{
                    star.image = customization.halfImage
                    computedValue = 0.0
                    star.tintColor = customization.fillTintColor
                } else {
                    star.image = customization.emptyImage
                    star.tintColor = customization.fillTintColor
                }
            }
    }
    
}

//Обертка с ограничением по значению
@propertyWrapper
struct Clamping<Value: Comparable> {
    var value: Value
    let range: ClosedRange<Value>

    init(initialValue: Value, range: ClosedRange<Value>) {
        precondition(range.contains(initialValue))
        self.value = initialValue
        self.range = range
    }

    var wrappedValue: Value {
        get { value }
        set { value = min(max(range.lowerBound, newValue), range.upperBound) }
    }
}
