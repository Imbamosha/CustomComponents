//
//  AlertViewContainer.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 29.05.2021.
//

import UIKit

enum AlertViewType {
    case rating(RatingAlertViewModel)
}

protocol AlertViewContrainerDelegate: AnyObject {
    
    func closeGame()
    func restartGame()
}

class AlertViewContainer: UIView {
    
    private weak var alertView: UIView!
    private weak var backgroundView: UIView!
    
    private let alertViewLayouts = AlertContainerViewLayouts.AlertLayouts()
    private let backgroundViewLayouts = AlertContainerViewLayouts.BackgroundViewLayouts()
    
    init(alertViewType: AlertViewType) {
        viewType = alertViewType
        
        super.init(frame: UIScreen.main.bounds)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewType: AlertViewType
    
    weak var delegate: AlertViewContrainerDelegate?
}

extension AlertViewContainer {
    
    private func setupView() {
        setupBackgroundView()
        
        switch viewType {
        case let .rating(ratingAlertView):
            setupRatingView(viewModel: ratingAlertView)
        }
    }
    
    private func setupBackgroundView() {
        let background = UIView(frame: UIScreen.main.bounds)
        background.backgroundColor = .black
        background.alpha = 0.0
        
        backgroundView = background
        addSubview(backgroundView)
        //backgroundViewLayouts.initial(backgroundView)
    }
    
    private func setupRatingView(viewModel: RatingAlertViewModel) {
        let ratingAlert = RatingAlertView()
        ratingAlert.viewModel = viewModel
        ratingAlert.delegate = self
        
        alertView = ratingAlert
        addSubview(alertView)
        alertViewLayouts.initial(alertView)
    }
    
    func showAlert(_ controller: UIViewController) {
        
        frame = UIScreen.main.bounds
        alpha = 0.0
        
        if let navigationController = controller.navigationController {
            navigationController.view.addSubview(backgroundView)
            navigationController.view.addSubview(self)
        } else {
            controller.view.addSubview(backgroundView)
            controller.view.addSubview(self)
        }
        
        alertView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions(), animations: {
            self.alpha = 1.0
            self.backgroundView.alpha = 0.4
            self.alertView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.layoutIfNeeded()
        }, completion: { (Bool) -> Void in
            self.becomeFirstResponder()
        })
    }
    
}

extension AlertViewContainer: RatingAlertViewDelegate {
    
    func closeGameDidTouch() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.alpha = 0.0
            self.backgroundView.alpha = 0.0
            self.alertView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            self.layoutIfNeeded()
        }, completion: { (complete: Bool) in
            self.removeFromSuperview()
            self.backgroundView.removeFromSuperview()
        })
        
        delegate?.closeGame()
    }
    
    func restartGameDidTouch() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.alpha = 0.0
            self.backgroundView.alpha = 0.0
            self.alertView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            self.layoutIfNeeded()
        }, completion: { (complete: Bool) in
            self.removeFromSuperview()
            self.backgroundView.removeFromSuperview()
        })
        
        delegate?.restartGame()
    }
    
    
}
