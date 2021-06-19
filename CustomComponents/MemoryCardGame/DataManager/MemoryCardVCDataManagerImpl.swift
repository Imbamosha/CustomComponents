//
//  MemoryCardVCDataManagerImpl.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 25.05.2021.
//

import UIKit

class MemoryCardVCDataManagerImpl: NSObject {
    
    private var viewModel: [CardViewModel]?
    
    var delegate: MemoryCardVCDataManagerDelegate?
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
}

extension MemoryCardVCDataManagerImpl: MemoryCardVCDataManager {
  
    func update(with viewModels: [CardViewModel]) {
        viewModel = viewModels
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let viewModel = viewModel else { return 0 }
        
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { fatalError() }
        
        let cell = collectionView.dequeueReusableCell(withType: MemoryCardCollectionViewCell.self, for: indexPath)
        let shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 20)
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowOpacity = 0.25
        cell.layer.shadowPath = shadowPath.cgPath
        
        cell.showCard(false, animated: false)
        
        cell.viewModel = viewModel[indexPath.row]
       
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MemoryCardCollectionViewCell

        if cell.shown { return }
        delegate?.didSelectCard(cell.viewModel!)
    
        collectionView.deselectItem(at: indexPath, animated:true)
    }

}

extension MemoryCardVCDataManagerImpl: UICollectionViewDelegateFlowLayout {
    
    // Collection view flow layout setup
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Int(sectionInsets.left) * 4
        let availableWidth = Int(collectionView.frame.width) - paddingSpace
        let widthPerItem = availableWidth / 4
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}


