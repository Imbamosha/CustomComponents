//
//  TilesView.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 24.03.2021.
//

import Foundation

protocol TilesViewDelegate: AnyObject {
    
    func scrollDidEnd()
    
}

protocol TilesView: AnyObject {
 
    func update(with viewModel: TilesViewModel)
    
}
