//
//  MemoryCardVCDataManager.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 25.05.2021.
//

import UIKit

protocol MemoryCardVCDataManagerDelegate: AnyObject {
    
    func didSelectCard(_ viewModel: CardViewModel)
}
 
protocol MemoryCardVCDataManager: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func update(with viewModels: [CardViewModel])
    
    var delegate: MemoryCardVCDataManagerDelegate? { get set }
}
