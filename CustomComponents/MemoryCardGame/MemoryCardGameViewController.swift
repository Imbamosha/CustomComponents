//
//  MemoryCardGameViewController.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 25.05.2021.
//

import UIKit

enum LevelState {
    case easy
    case medium
    case hard
}

class MemoryCardGameViewController: UIViewController {
    
    private weak var closeButton: UIButton!
    
    private weak var onboardingView: MemoryGameOnboardingView!
    
    private weak var memoryCardsCollectionView: UICollectionView!
    private weak var timerLabel: UILabel!
    private weak var stopButton: FloatingButton!
    private weak var restartButton: FloatingButton!
    
    private let closeButtonLayout = MemoryCardGameVCLayouts.CloseButtonLayout()
    private let onboardingViewLayouts = MemoryCardGameVCLayouts.OnboardingViewLayout()
    private let memoryCardsCollectionViewLayouts = MemoryCardGameVCLayouts.CollectionViewLayout()
    private let timerLayout = MemoryCardGameVCLayouts.TimerLabelLayout()
    private let stopButtonLayout = MemoryCardGameVCLayouts.StartButtonLayout()
    private let restartButtonLayout = MemoryCardGameVCLayouts.ResetGameButtonLayout()
    
    private var dataManager = MemoryCardVCDataManagerImpl()
    
    private let cellTypes = [MemoryCardCollectionViewCell.self]
    
    var timeSecondsСounter = 0
    
    var time = Timer()
    
    let game: MemoryGame = MemoryGame()
    
    let defaults = UserDefaults.standard
    
    var cards = [CardViewModel]()
    
    private var currentLevel: LevelState = .easy {
        didSet {
            setupCardsArray(level: currentLevel)
            setupNewGame()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


//MARK: - Setup Game
extension MemoryCardGameViewController {
    
    private func setupSubviews() {
        self.view.backgroundColor = .white
        
        setupCloseButton()
        setupStopButton()
        setupTimer()
        setupRestartButton()
        setupCollectionView()
        setupOnboardingView()
    }
    
    private func setupCloseButton() {
        let button = UIButton()
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        
        button.addTarget(self, action: #selector(closeButtonDidTouch), for: .touchUpInside)
        closeButton = button
        view.addSubview(closeButton)
        closeButtonLayout.initial(closeButton)
    }
    
    private func setupOnboardingView() {
        let onboarding = MemoryGameOnboardingView()
        onboarding.backgroundColor = .white
        onboarding.delegate = self
        
        onboardingView = onboarding
        view.addSubview(onboarding)
        
        onboardingViewLayouts.initial(onboardingView)
    }
    
    private func setupStopButton() {
        let button = FloatingButton(target: self, tapAction: #selector(endGameDidTap))
        button.setBackgroundColor(UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0))
        button.labelText = "Сложность"
        
        self.stopButton = button
        view.addSubview(stopButton)
        stopButtonLayout.initial(stopButton)
    }
    
    private func setupRestartButton() {
        let button = FloatingButton(target: self, tapAction: #selector(restartDidTap))
        button.setBackgroundColor(UIColor(red: 1, green: 160/255, blue: 122/255, alpha: 1.0))
        button.labelText = "Обновить"
        
        self.restartButton = button
        view.addSubview(restartButton)
        restartButtonLayout.initial(restartButton)
    }
    
    private func setupTimer() {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        timerLabel = label
        view.addSubview(timerLabel)
        timerLayout.initial(timerLabel, to: stopButton)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        dataManager.delegate = self
        collectionView.dataSource = dataManager
        collectionView.delegate = dataManager
        collectionView.registerWithoutNib(cellTypes: cellTypes)
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = false
        
        memoryCardsCollectionView = collectionView
        view.addSubview(memoryCardsCollectionView)
        memoryCardsCollectionViewLayouts.initial(memoryCardsCollectionView, to: stopButton)
        
        game.delegate = self
    }
    
    private func setupCardsArray(level: LevelState) {
        var cardImages: [UIImage] = []
        
        switch level {
        case .easy:
            cardImages = [
                UIImage(named: "cat")!,
                UIImage(named: "dog")!,
                UIImage(named: "fox")!,
                UIImage(named: "koala")!,
            ]
        case .medium:
            cardImages = [
                UIImage(named: "cat")!,
                UIImage(named: "dog")!,
                UIImage(named: "fox")!,
                UIImage(named: "koala")!,
                UIImage(named: "lion")!,
                UIImage(named: "owl")!,
            ]
        case .hard:
            cardImages = [
                UIImage(named: "cat")!,
                UIImage(named: "dog")!,
                UIImage(named: "fox")!,
                UIImage(named: "koala")!,
                UIImage(named: "lion")!,
                UIImage(named: "owl")!,
                UIImage(named: "pig")!,
                UIImage(named: "bear")!
            ]
        }
        var cardsArray = [CardViewModel]()
        
        for image in cardImages {
            let card = CardViewModel(image: image)
            let copy = card.copy()
            if currentLevel == .hard {
                let copy2 = card.copy()
                cardsArray.append(copy2)
            }
            cardsArray.append(card)
            cardsArray.append(copy)
           
        }
        self.cards = cardsArray
    }
    
    private func startTimer() {
        timeSecondsСounter = 0
        timerLabel.text = "0 c"
        
        time.invalidate()
        time = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(timerAction),
            userInfo: nil,
            repeats: true
        )

    }
}

//MARK: - Private methods
extension MemoryCardGameViewController {
    
    private func setupNewGame() {
        self.cards = game.newGame(cardsArray: self.cards, level: currentLevel)
        
        dataManager.update(with: cards)
        
        memoryCardsCollectionView.reloadData()
        
        startTimer()
    }
    
    private func resetGame() {
        game.restartGame()
        setupNewGame()
        startTimer()
    }
    
    private func saveCurrentTime(value: Int) -> (currentTime: Int, bestTimeOnLevel: Int) {
        let key = String(describing: currentLevel)
        let previousRecord = defaults.integer(forKey: key)
        var bestTime = previousRecord
        
        if previousRecord != 0, previousRecord > value {
            defaults.setValue(value, forKey: key)
            bestTime = value
        } else if previousRecord == 0 {
            bestTime = value
            defaults.setValue(value, forKey: key)
        }
        
        return (value, bestTime)
    }
    
    private func calculateResultRating(time: Int) -> Double {
        switch currentLevel {
        case .easy:
            if time < 15 {
                return 5
            } else if time >= 15 && time < 20 {
                return 4
            } else if time >= 20 && time < 30 {
                return 3
            } else if time >= 30 && time < 40 {
                return 2
            } else {
                return 1
            }
        case .medium:
            if time < 25 {
                return 5
            } else if time >= 25 && time < 30 {
                return 4
            } else if time >= 30 && time < 40 {
                return 3
            } else if time >= 40 && time < 50 {
                return 2
            } else {
                return 1
            }
        case.hard:
            if time < 45 {
                return 5
            } else if time >= 45 && time < 50 {
                return 4
            } else if time >= 50 && time < 60 {
                return 3
            } else if time >= 60 && time < 70 {
                return 2
            } else {
                return 1
            }
        }
    }
    
}

extension MemoryCardGameViewController: MemoryGameProtocol {
    
    func memoryGameDidStart(_ game: MemoryGame) {
//        memoryCardsCollectionView.reloadData()
    }
    
    func memoryGameDidEnd(_ game: MemoryGame) {
        time.invalidate()
        
        let resultValue = saveCurrentTime(value: timeSecondsСounter)
        let calculatedRating = calculateResultRating(time: timeSecondsСounter)
        
        let ratingViewModel = RatingAlertViewModel(rating: calculatedRating, currentTime: "\(resultValue.currentTime) c", bestRecordTime: "\(resultValue.bestTimeOnLevel) c")
        
        let alertView = AlertViewContainer(alertViewType: .rating(ratingViewModel))
        alertView.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            alertView.showAlert(self)
        }
    }
    
    func memoryGame(_ game: MemoryGame, showCards cards: [CardViewModel]) {
        for card in cards {
            guard let index = game.indexForCard(card) else { continue }
            let cell = memoryCardsCollectionView.cellForItem(at: IndexPath(item: index, section:0)) as! MemoryCardCollectionViewCell
            cell.showCard(true, animated: true)
        }
    }
    
    func memoryGame(_ game: MemoryGame, hideCards cards: [CardViewModel]) {
        for card in cards {
            guard let index = game.indexForCard(card) else { continue }
            let cell = memoryCardsCollectionView.cellForItem(at: IndexPath(item: index, section:0)) as! MemoryCardCollectionViewCell
            cell.showCard(false, animated: true)
        }
    }
    
}

extension MemoryCardGameViewController: MemoryCardVCDataManagerDelegate {
    
    func didSelectCard(_ viewModel: CardViewModel) {
        game.didSelectCard(viewModel)
    }

}

//MARK: - Actions
extension MemoryCardGameViewController {
    
    @objc private func endGameDidTap() {
        setupOnboardingView()
        self.view.layoutIfNeeded()
    }
    
    @objc private func restartDidTap() {
        resetGame()
    }
    
    @objc func timerAction() {
        timeSecondsСounter += 1
        timerLabel.text = "\(timeSecondsСounter) с"
    }
    
    @objc func closeButtonDidTouch() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension MemoryCardGameViewController: MemoryGameOnboardingViewDelegate {
    
    func startButtonDidTouch(with level: LevelState) {
        DispatchQueue.main.async {
            self.onboardingViewLayouts.hide(self.onboardingView)
            UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
                self.onboardingView.alpha = 0.0
            }) { _ in
                self.onboardingView.removeFromSuperview()
            }
        }
        
        currentLevel = level
    }
    
}

extension MemoryCardGameViewController: AlertViewContrainerDelegate {
    
    func closeGame() {
        setupOnboardingView()
        self.view.layoutIfNeeded()
    }
    
    func restartGame() {
        resetGame()
    }
    
}
