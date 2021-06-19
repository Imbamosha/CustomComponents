//
//  TilesCollectionViewDataManagerImpl.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 25.03.2021.
//


import UIKit

class TilesCollectionViewDataManagerImpl: NSObject {
    
    private var viewModel: TilesViewModel?
    
    private var collectionViewFlowLayout: UICollectionViewFlowLayout
    
    private var cellWidth: CGFloat = 0
    
    private var currentPage: Int = 0
    
    var beginXOffset: CGFloat = 0.0
    
    weak var delegate: TilesCollectionViewDataManagerDelegate?
    
    init(collectionViewFlowLayout: UICollectionViewFlowLayout) {
        self.collectionViewFlowLayout = collectionViewFlowLayout
    }
}

extension TilesCollectionViewDataManagerImpl: TilesCollectionViewDataManager {
    func update(with viewModel: TilesViewModel) {
        self.viewModel = viewModel
    }
    
}

extension TilesCollectionViewDataManagerImpl: UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let _ = viewModel else { return 0 }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        
        return viewModel.postcards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { fatalError() }
        
        let cell = collectionView.dequeueReusableCell(withType: TileCollectionViewCell.self, for: indexPath)
        let shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 20)
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.shadowOpacity = 0.25
        cell.layer.shadowPath = shadowPath.cgPath
        cell.viewModel = viewModel.postcards[indexPath.row]
        
        return cell
    }
    
}

extension TilesCollectionViewDataManagerImpl: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = UIScreen.main.bounds.height * 0.66
        let screenWidth = cellHeight * 0.594
        
        self.cellWidth = screenWidth
        
        return CGSize(width: screenWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        guard let viewModel = viewModel, viewModel.postcards.count == 1 else { return UIEdgeInsets(top: 0, left: 16, bottom: 5, right: 16)}
        
        let inset = (collectionView.bounds.width - CGFloat(cellWidth)) / 2
        return UIEdgeInsets(top: 0, left: inset, bottom: 5, right: inset)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.beginXOffset = scrollView.contentOffset.x
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        
        let indexPath = IndexPath(row: self.indexOfMajorCell(currentXOffset: scrollView.contentOffset.x),
                                  section: 0)
        collectionViewFlowLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if let viewModel = viewModel {
            delegate?.scrollDidEnd(id: viewModel.postcards[indexPath.row].id)
        }
        
    }
    
    private func indexOfMajorCell(currentXOffset: CGFloat) -> Int {
        let proportionalOffset = (collectionViewFlowLayout.collectionView!.contentOffset.x) / (cellWidth)
        let index = currentXOffset < self.beginXOffset
            ? Int(round(proportionalOffset - 0.4))
            : Int(round(proportionalOffset + 0.4))
        
        let numberOfItems = viewModel?.postcards.count ?? 1
        let safeIndex = max(0, min(numberOfItems - 1, index))
        return safeIndex
    }
}

