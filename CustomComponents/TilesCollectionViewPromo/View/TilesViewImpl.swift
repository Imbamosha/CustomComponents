//
//  TilesViewImpl.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 24.03.2021.
//

import UIKit

class TilesViewImpl: UIView {
    
    //MARK: - UIComponents
    private weak var tilesListCollectionView: UICollectionView!
    private weak var loadingView: UIView!
    
    //MARK: - Constraints
    private let tilesListCollectionViewLayout = TilesViewLayouts.CollectionViewLayouts()
    
    private let cellTypes = [
        TileCollectionViewCell.self
    ]
    
    weak var delegate: TilesViewDelegate?
    
    private var tilesDataManager: TilesCollectionViewDataManager!
    
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
    
    private var viewModel: TilesViewModel?
    
    private var currentPostcardId: String = "0"
}

//MARK: - Interface
extension TilesViewImpl: TilesView {
    
    func update(with viewModel: TilesViewModel) {
        tilesDataManager.update(with: viewModel)
        tilesListCollectionView.reloadData()
    }

}



//MARK: - Private methods
extension TilesViewImpl {
    
    private func setupSubviews() {
        setupBackgroundImageView()
        setupTilesCollectionView()
    }
    
    private func setupBackgroundImageView() {
        self.backgroundColor = UIColor(red: 0.87, green: 0.811, blue: 0.75, alpha: 1.0)
    }
    
    private func setupTilesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let dataManager = TilesCollectionViewDataManagerImpl(collectionViewFlowLayout: layout)
        self.tilesDataManager = dataManager
        
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        tilesDataManager.delegate = self
        collectionView.dataSource = tilesDataManager
        collectionView.delegate = tilesDataManager
        collectionView.registerWithoutNib(cellTypes: cellTypes)
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = false
        
        tilesListCollectionView = collectionView
        addSubview(tilesListCollectionView)
        tilesListCollectionViewLayout.initial(tilesListCollectionView)
    }
}

//MARK: - Actions
extension TilesViewImpl {

}

extension TilesViewImpl: TilesCollectionViewDataManagerDelegate {
    
    func scrollDidEnd(id: String) {
        currentPostcardId = id
        delegate?.scrollDidEnd()
    }
    
}
