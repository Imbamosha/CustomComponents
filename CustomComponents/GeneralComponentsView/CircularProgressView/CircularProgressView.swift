//
//  CircularProgressViewImpl.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 26.03.2021.
//

import UIKit

public class CircularProgressView: UIView {
    
    struct Customization {
        enum IntervalAnimationStyle {
            case `default`
            case progressive
        }
        
        let strokeFillColor: CGColor
        let strokeBaseColor: CGColor
        let fillColor: CGColor
        let lineWidth: CGFloat
        let textColor: UIColor
        let animationDuration: TimeInterval
        let stepNumber: Int
        let intervalStyle: Customization.IntervalAnimationStyle
        let valueLabelText: String
    }
    
    private weak var circleLayer: CAShapeLayer!
    private weak var progressLayer: CAShapeLayer!
    private weak var valueLabel: UILabel!
    
    private let customization: Customization!
    private var animation: CABasicAnimation!
    
    init(frame: CGRect, customization: CircularProgressView.Customization) {
        self.customization = customization
        super.init(frame: frame)
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private lazy var stepValue: Double = Double(1) / Double(customization.stepNumber)
    
    private var progressValue: Double = 0
    
    private var currentStep: Int = 0
    
}

//MARK: - Private methods
extension CircularProgressView {
    
    public func updateProgressView(value: Int) {
        if currentStep != customization.stepNumber || value < 0 {
            currentStep += value
        }
        
        animation.duration = customization.animationDuration
        animation.fromValue = progressValue
        progressValue = Double(currentStep) * stepValue
        animation.toValue = progressValue
        
        valueLabel.text = currentStep == 0 ? "" : "\(currentStep) \(customization.valueLabelText)"

        progressLayer.add(animation, forKey: "progressAnim")
        
        switch customization.intervalStyle {
        case .progressive:
            if progressValue > 0.4 && progressValue < 0.8 {
                let color = UIColor(red: 1, green: 160/255, blue: 122/255, alpha: 1.0).cgColor
                progressLayer.strokeColor = color
            } else if progressValue >= 0.8 {
                let color = UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0).cgColor
                progressLayer.strokeColor = color
            } else {
                progressLayer.strokeColor = customization.strokeFillColor
            }
        default:
            break
        }
    }
    
}

//MARK: - Private methods
extension CircularProgressView {
    
    private func setupView() {
        setupCircularPath()
        setupPercentValueLabel()
        setupAnimation()
        
        layoutSubviews()
    }
    
    private func setupCircularPath() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0), radius: bounds.height/2 , startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        
        let circle = CAShapeLayer()
        circle.path = circularPath.cgPath
        circle.fillColor = customization.fillColor
        circle.lineCap = .round
        circle.lineWidth = customization.lineWidth
        circle.strokeColor = customization.strokeBaseColor
        circleLayer = circle
        
        let progress = CAShapeLayer()
        progress.path = circularPath.cgPath
        progress.fillColor = UIColor.clear.cgColor
        progress.lineCap = .round
        progress.lineWidth = customization.lineWidth + 3
        progress.strokeEnd = 0
        progress.strokeColor = customization.strokeFillColor
       
        progressLayer = progress
        
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }
    
    private func setupPercentValueLabel() {
        let proteinValueLabel = UILabel(frame: CGRect(x: bounds.width/4, y: bounds.height/4, width: bounds.width/2, height: bounds.height/2))
        proteinValueLabel.numberOfLines = 0
        proteinValueLabel.textAlignment = .center
        proteinValueLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        proteinValueLabel.text = ""
        proteinValueLabel.textColor = customization.textColor
        valueLabel = proteinValueLabel
        addSubview(valueLabel)
    }
    
    private func setupAnimation() {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.fillMode = .both
        circularProgressAnimation.isRemovedOnCompletion = false
        
        animation = circularProgressAnimation
    }
    
}
