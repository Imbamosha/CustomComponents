//
//  MemoryCardCollectionViewCell.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 25.05.2021.
//

import UIKit

protocol MemoryCardTableViewCellDelegate: AnyObject {
    
}

class MemoryCardCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UIComponents
    private weak var frontSideView: UIView!
    private weak var tileMainImageView: UIImageView!
    private weak var tileBackgroundView: UIView!
    
    private weak var backSideView: UIView!
    //private weak var backSideImageView: UIImageView!
    
    //MARK: - Layouts
    private let cardLayout = MemoryCardTableViewCellLayouts()
    //MARK: - Front
    private let cardMainImageLayout = MemoryCardTableViewCellLayouts.ImageViewLayout()
   
    //MARK: - Back
    private let backgroundImageLayout = MemoryCardTableViewCellLayouts.BackgroundImageLayout()
    
    var viewModel: CardViewModel? { didSet { updateSubviews() }}
    
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
    
    var shown: Bool = false
    
}

extension MemoryCardCollectionViewCell {
    
    func update(with viewModel: CardViewModel) {
        self.viewModel = viewModel
    }
    
}
//MARK: - Private methods
extension MemoryCardCollectionViewCell {
    
    private func setupSubviews() {
        setupFrontSideView()
        setupTileImageView()
        setupBackSideView()
    }
    
    private func setupFrontSideView() {
        let front = UIView()
        front.backgroundColor = .white
        front.layer.cornerRadius = 20
        front.layer.masksToBounds = true
        
        frontSideView = front
        addSubview(frontSideView)
        cardLayout.initial(frontSideView)
    }
    
    private func setupTileImageView() {
        let image = UIImageView()
        image.isHidden = false
        tileMainImageView = image
        
        frontSideView.addSubview(tileMainImageView)
        cardMainImageLayout.initial(tileMainImageView)
    }
    
    private func setupBackSideView() {
        let back = UIView()
        back.backgroundColor = UIColor(red: 181/255, green: 234/255, blue: 215/255, alpha: 1.0)
        back.layer.cornerRadius = 20
        back.layer.masksToBounds = true
        
        backSideView = back
        addSubview(backSideView)
        cardLayout.initial(backSideView)
    }

    
    private func updateSubviews() {
        guard let viewModel = viewModel else { return }
        
        switch shown {
        case true:
            self.frontSideView.isHidden = false
            self.backSideView.isHidden = true
        default:
            self.frontSideView.isHidden = true
            self.backSideView.isHidden = false
        }
        
        self.tileMainImageView.image = viewModel.frontImageView
    }
    
    
    func showCard(_ show: Bool, animated: Bool) {
        frontSideView.isHidden = false
        backSideView.isHidden = false
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        shown = show
        
        if animated {
            switch show{
            case true:
                UIView.transition(from: backSideView, to: frontSideView, duration: 1.0, options: transitionOptions, completion: nil)
            case false:
                UIView.transition(from: frontSideView, to: backSideView, duration: 1.0, options: transitionOptions, completion: nil)
            }
        } else {
            switch show{
            case true:
                bringSubviewToFront(frontSideView)
                backSideView.isHidden = true
            case false:
                bringSubviewToFront(backSideView)
                frontSideView.isHidden = true
            }
            
        }
        
    }
}
