//
//  TileCollectionViewCell.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 25.03.2021.
//

import UIKit

protocol TileCollectionViewCellDelegate: AnyObject {
    
}

class TileCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UIComponents
    private weak var frontSideView: UIView!
    private weak var titleLabel: UILabel!
    private weak var tileMainImageView: UIImageView!
    private weak var tileBackgroundView: UIView!
    private weak var actionButton: UIButton!
    
    private weak var backSideView: UIView!
    private weak var descriptionTitleLabel: UILabel!
    private weak var descriptionLabel: UILabel!
    
    //MARK: - Common Layouts
    private let tileLayout = TileCollectionViewCellLayouts()
    //MARK: - Front
    private let tileMainImageLayout = TileCollectionViewCellLayouts.ImageViewLayout()
    private let titleLabelLayout = TileCollectionViewCellLayouts.TitleLabelLayout()
   
    //MARK: - Back
    private let descriptionLabelLayout = TileCollectionViewCellLayouts.DescriptionLabelLayout()
    
    var viewModel: TileViewModel? { didSet { updateSubviews() }}
    
    weak var delegate: TileCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
}

//MARK: - Private methods
extension TileCollectionViewCell {
    
    private func setupSubviews() {
        setupFrontSideView()
        setupTitleLabel()
        setupTileImageView()
        setupBackSideView()
        setupDescriptionTitleLabel()
        setupDescriptionLabel()
        setupAction()
    }
    
    private func setupBackgroundView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        backgroundView.layer.cornerRadius = 24
        backgroundView.layer.masksToBounds = true
        
        tileBackgroundView = backgroundView
        addSubview(tileBackgroundView)
        tileLayout.initial(tileBackgroundView)
    }
    
    private func setupFrontSideView() {
        let front = UIView()
        front.backgroundColor = .white
        front.layer.cornerRadius = 24
        front.layer.masksToBounds = true
        
        frontSideView = front
        addSubview(frontSideView)
        tileLayout.initial(frontSideView)
    }
    
    private func setupTitleLabel() {
        let title = UILabel()
        title.numberOfLines = 0
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        title.textColor = .black
        
        titleLabel = title
        frontSideView.addSubview(titleLabel)
        titleLabelLayout.initial(titleLabel)
    }
    
    private func setupTileImageView() {
        let image = UIImageView()
        image.isHidden = false
        tileMainImageView = image
        
        frontSideView.addSubview(tileMainImageView)
        tileMainImageLayout.initial(tileMainImageView, to: titleLabel)
    }
    
    private func setupBackSideView() {
        let back = UIView()
        back.backgroundColor = .white
        back.layer.cornerRadius = 24
        back.layer.masksToBounds = true
        
        backSideView = back
        addSubview(backSideView)
        tileLayout.initial(backSideView)
    }
    
    private func setupDescriptionTitleLabel() {
        let title = UILabel()
        title.numberOfLines = 0
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        title.textColor = .black
        title.text = "Описание"
        
        descriptionTitleLabel = title
        backSideView.addSubview(descriptionTitleLabel)
        titleLabelLayout.initial(descriptionTitleLabel)
    }
    
    private func setupDescriptionLabel() {
        let description = UILabel()
        
        description.numberOfLines = 0
        description.textAlignment = .left
        description.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        description.textColor = .black
        
        descriptionLabel = description
        backSideView.addSubview(descriptionLabel)
        descriptionLabelLayout.initial(descriptionLabel, to: descriptionTitleLabel)
    }
    
    private func setupAction() {
        let button = UIButton()
        
        button.addTarget(self, action: #selector(flip), for: .touchUpInside)
        actionButton = button
        addSubview(actionButton)
        tileLayout.initial(actionButton)
    }
    
    private func updateSubviews() {
        guard let viewModel = viewModel else { return }
        
        switch viewModel.state {
        case .front:
            self.frontSideView.isHidden = false
            self.backSideView.isHidden = true
        default:
            self.frontSideView.isHidden = true
            self.backSideView.isHidden = false
        }
        
        self.titleLabel.text = viewModel.title
        self.tileMainImageView.image = UIImage(named: viewModel.mainImage)
        self.descriptionLabel.text = viewModel.description
    }
    
    
    @objc func flip() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        switch viewModel?.state {
        case .front:
            viewModel?.state = .back
            UIView.transition(from: frontSideView, to: backSideView, duration: 1.0, options: transitionOptions, completion: nil)
        case .back:
            viewModel?.state = .front
            UIView.transition(from: backSideView, to: frontSideView, duration: 1.0, options: transitionOptions, completion: nil)
        default: break
        }
    }
    
}


