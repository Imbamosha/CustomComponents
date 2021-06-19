//
//  MemoryGame.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 25.05.2021.
//

import UIKit

// MARK: - MemoryGameProtocol
protocol MemoryGameProtocol {
    //protocol definition goes here
    func memoryGameDidStart(_ game: MemoryGame)
    func memoryGameDidEnd(_ game: MemoryGame)
    func memoryGame(_ game: MemoryGame, showCards cards: [CardViewModel])
    func memoryGame(_ game: MemoryGame, hideCards cards: [CardViewModel])
}

// MARK: - MemoryGame
class MemoryGame {
    
    // MARK: - Properties
    var delegate: MemoryGameProtocol?
    
    private var cards:[CardViewModel] = [CardViewModel]()
    
    private var cardsShown:[CardViewModel] = [CardViewModel]()
    
    private var isPlaying: Bool = false
    
    private var currentLevel: LevelState = .easy
    
    // MARK: - Methods
    
    func newGame(cardsArray:[CardViewModel], level: LevelState) -> [CardViewModel] {
        restartGame()
        self.currentLevel = level
        cards = shuffleCards(cards: cardsArray)
        isPlaying = true
    
        delegate?.memoryGameDidStart(self)
        
        return cards
    }
    
    func restartGame() {
        isPlaying = false
        
        cards.removeAll()
        cardsShown.removeAll()
    }

    func cardAtIndex(_ index: Int) -> CardViewModel? {
        if cards.count > index {
            return cards[index]
        } else {
            return nil
        }
    }

    func indexForCard(_ card: CardViewModel) -> Int? {
        for index in 0...cards.count-1 {
            if card === cards[index]{
                return index
            }
        }
        return nil
    }

    func didSelectCard(_ card: CardViewModel?) {
        switch currentLevel {
        case .hard:
            rulesForThreeCards(card: card)
        default:
            rulesForTwoCards(card: card)
        }
    }
    
    
    
}

//MARK: - Private methods
extension MemoryGame {
    
    private func endGame() {
        isPlaying = false
        delegate?.memoryGameDidEnd(self)
    }
    
    private func unmatchedCardShown() -> Bool {
        switch currentLevel {
        case .easy:
            return cardsShown.count % 2 != 0
        case .medium:
            return cardsShown.count % 2 != 0
        case .hard:
            return cardsShown.count % 3 != 0
        }
    }
    
    private func unmatchedCard() -> CardViewModel? {
        let unmatchedCard = cardsShown.last
        return unmatchedCard
    }
    
    private func shuffleCards(cards:[CardViewModel]) -> [CardViewModel] {
        var randomCards = cards
        randomCards.shuffle()
        
        return randomCards
    }
    
}

//MARK: Правила для разных уровней сложности
extension MemoryGame {
    
    private func rulesForTwoCards(card: CardViewModel?) {
        guard let card = card else { return }
        
        delegate?.memoryGame(self, showCards: [card])
        
        if unmatchedCardShown() {
            let unmatched = unmatchedCard()!
            
            if card.equals(unmatched) {
                cardsShown.append(card)
            } else {
                let secondCard = cardsShown.removeLast()
                
                let delayTime = DispatchTime.now() + 1.0
                DispatchQueue.main.asyncAfter(deadline: delayTime) {
                    self.delegate?.memoryGame(self, hideCards:[card, secondCard])
                }
            }
            
        } else {
            cardsShown.append(card)
        }
        
        if cardsShown.count == cards.count {
            endGame()
        }
    }
    
    private func rulesForThreeCards(card: CardViewModel?) {
        guard let card = card else { return }
        
        delegate?.memoryGame(self, showCards: [card])
        
        if unmatchedCardShown() {
            let unmatched = unmatchedCard()!
            
            if card.equals(unmatched) {
                cardsShown.append(card)
            } else {
                if cardsShown.count == 2 {
                    let secondCard = cardsShown.removeLast()
                    let thirdCard = cardsShown.removeLast()
                    let delayTime = DispatchTime.now() + 1.0
                    DispatchQueue.main.asyncAfter(deadline: delayTime) {
                        self.delegate?.memoryGame(self, hideCards:[card, secondCard, thirdCard])
                    }
                } else {
                    let secondCard = cardsShown.removeLast()
                    
                    let delayTime = DispatchTime.now() + 1.0
                    DispatchQueue.main.asyncAfter(deadline: delayTime) {
                        self.delegate?.memoryGame(self, hideCards:[card, secondCard])
                    }
                }
            }
            
        } else {
            cardsShown.append(card)
        }
        
        if cardsShown.count == cards.count {
            endGame()
        }
    }
}




