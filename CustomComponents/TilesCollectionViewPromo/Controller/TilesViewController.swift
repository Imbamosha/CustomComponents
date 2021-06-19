//
//  TilesViewController.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 26.03.2021.
//

import UIKit

enum TilesViewControllerState {
    case loading
    case viewModel(TilesViewModel)
}

protocol TilesViewController: AnyObject {
    
    func display(with state: TilesViewControllerState)
    
}
