//
//  CardViewModel.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 25.05.2021.
//

import UIKit

class CardViewModel {

    var id: String
    var shown: Bool = false
    var frontImageView: UIImage
    var backImageView: UIImage = UIImage(named: "minus")!
    
    init(image: UIImage) {
        self.id = NSUUID().uuidString
        self.shown = false
        self.frontImageView = image
    }
    
    // MARK: - Methods
    func equals(_ card: CardViewModel) -> Bool {
        return (card.id == id)
    }
    
    private init(card: CardViewModel) {
        self.id = card.id
        self.shown = card.shown
        self.frontImageView = card.frontImageView
        self.backImageView = card.backImageView
    }
    
    func copy() -> CardViewModel {
        return CardViewModel(card: self)
    }
}

extension Array {
    
    mutating func shuffle() {
        for _ in 0...self.count {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
