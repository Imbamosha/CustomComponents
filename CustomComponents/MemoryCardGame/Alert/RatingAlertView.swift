//
//  RatingAlertView.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 29.05.2021.
//

import UIKit

protocol RatingAlertViewDelegate: AnyObject {
    
    func closeGameDidTouch()
    
    func restartGameDidTouch()
}

class RatingAlertView: UIView {
    
    //MARK: - UIComponents
    private weak var titleLabel: UILabel!
    private weak var restartButton: FloatingButton!
    private weak var ratingStarView: StarRatingView!
    private weak var recordLabel: UILabel!
    private weak var closeButton: FloatingButton!
    
    private let titleLabelLayout = AlertViewLayouts.TitleLabelLayout()
    private let restartButtonLayout = AlertViewLayouts.RestartButtonLayout()
    private let closeButtonLayout = AlertViewLayouts.CloseButtonLayout()
    private let ratingStarViewLayout = AlertViewLayouts.RatingStackLayout()
    private let recordLabelLayout = AlertViewLayouts.RecordLabelLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: RatingAlertViewModel? { didSet {
        updateSubviews()
    }}
    
    weak var delegate: RatingAlertViewDelegate?
    
}

extension RatingAlertView {
    
    private func updateSubviews() {
        guard let viewModel = viewModel else { return }
        
        recordLabel.text = "Текущее время: \(viewModel.currentTime) \n\nЛучшее время на этом уровне: \(viewModel.bestRecordTime)"
        
        ratingStarView.value = viewModel.rating
    }
    
    private func setupSubviews() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        setupTitleLabel()
        setupRecordLabel()
        setupStarRatingStack()
        setupRestartButton()
        setupCloseButton()
    }
    
    private func setupTitleLabel() {
        let title = UILabel()
        
        title.text = "Отлично!"
        title.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        title.textAlignment = .center
        
        titleLabel = title
        addSubview(titleLabel)
        titleLabelLayout.initial(titleLabel)
    }
    
    private func setupRecordLabel() {
        let record = UILabel()
        record.numberOfLines = 0
        record.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        record.textAlignment = .left
        
        recordLabel = record
        addSubview(recordLabel)
        recordLabelLayout.initial(recordLabel, to: titleLabel)
    }
    
    private func setupStarRatingStack() {
        let customization = StarRatingView.Customization(
            fillImage: UIImage(named: "fillratingstar")!,
            halfImage: UIImage(named: "halfStar")!,
            emptyImage: UIImage(named: "ratingStar")!,
            spacing: 5,
            fillTintColor: UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0),
            maximumValue: 5
        )
        
        let rating = StarRatingView(customization: customization)
        
        ratingStarView = rating
        addSubview(ratingStarView)
        ratingStarViewLayout.initial(ratingStarView, to: recordLabel)
    }
 
    private func setupRestartButton() {
        let button = FloatingButton(target: self, tapAction: #selector(restartButtonDidTouch))
        button.setBackgroundColor(UIColor(red: 1, green: 160/255, blue: 122/255, alpha: 1.0))
        button.labelText = "Еще раз"
        
        restartButton = button
        
        addSubview(restartButton)
        closeButtonLayout.initial(restartButton, to: ratingStarView)
    }
    
    private func setupCloseButton() {
        let button = FloatingButton(target: self, tapAction: #selector(closeButtonDidTouch))
        button.setBackgroundColor(UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0))
        button.labelText = "Выйти из игры"
        
        closeButton = button
        
        addSubview(closeButton)
        closeButtonLayout.initial(closeButton, to: restartButton)
    }
    
}

extension RatingAlertView {
    
    @objc private func closeButtonDidTouch() {
        delegate?.closeGameDidTouch()
    }
    
    @objc private func restartButtonDidTouch() {
        delegate?.restartGameDidTouch()
    }
}
