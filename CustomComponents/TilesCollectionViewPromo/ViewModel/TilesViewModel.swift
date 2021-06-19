//
//  TilesViewModel.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 24.03.2021.
//

import Foundation

struct TileViewModel {
    enum State {
        case front
        case back
    }
    
    var id: String
    var state: State
    //Front
    var title: String
    var mainImage: String
    
    //Background
    var description: String
}

struct TilesViewModel {
    var postcards: [TileViewModel]
}
