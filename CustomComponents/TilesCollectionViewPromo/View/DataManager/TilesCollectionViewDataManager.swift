//
//  TilesCollectionViewDataManager.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 25.03.2021.
//

import UIKit

protocol TilesCollectionViewDataManagerDelegate: AnyObject {
    
    func scrollDidEnd(id: String)
}

protocol TilesCollectionViewDataManager: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func update(with viewModel: TilesViewModel)
    
    var delegate: TilesCollectionViewDataManagerDelegate? { get set }
}
