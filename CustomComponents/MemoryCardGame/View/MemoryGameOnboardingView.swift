//
//  MemoryGameOnboardingView.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 26.05.2021.
//

import UIKit

protocol MemoryGameOnboardingViewDelegate: AnyObject {
    
    func startButtonDidTouch(with level: LevelState)
}

class MemoryGameOnboardingView: UIView {
    
    private weak var titleLabel: UILabel!
    private weak var rulesLabel: UILabel!
    private weak var levelDescriptionLabel: UILabel!
    private weak var setupButton: FloatingButton!
    private weak var circularProgress: CircularProgressView!
    private weak var levelCountControl: CountControl!
    
    private let titleLabelLayout = MemoryGameOnboardingViewLayouts.TitleLabelLayout()
    private let rulesLabelLayout = MemoryGameOnboardingViewLayouts.RulesLabelLayout()
    private let levelDescriptionLabelLayout = MemoryGameOnboardingViewLayouts.LevelDescriptionLabelLayout()
    private let setupButtonLayout = MemoryGameOnboardingViewLayouts.SetupButtonLayout()
    private let circularProgressLayout = MemoryGameOnboardingViewLayouts.CircularProgressLayout()
    private let levelCountControlLayout = MemoryGameOnboardingViewLayouts.CountControlLayout()
    
    override init(frame: CGRect) {
        super.init(frame: .null)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var selectedLevel: LevelState? { didSet {
        updateSubviews()
    }}
    
    weak var delegate: MemoryGameOnboardingViewDelegate?
    
}

extension MemoryGameOnboardingView {
    
    private func setupSubviews() {
        self.backgroundColor = UIColor(red: 181/255, green: 234/255, blue: 215/255, alpha: 0.1)
        
        setupTitleLabel()
        setupRulesLabel()
        setupCountControl()
        setupCircularProgress()
        setupLevelDescriptionLabel()
        
        setupStartButton()
    }
    
    private func setupTitleLabel() {
        let title = UILabel()
        
        title.text = "Добро пожаловать"
        title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        title.textAlignment = .center
        
        titleLabel = title
        addSubview(titleLabel)
        titleLabelLayout.initial(titleLabel)
    }
    
    private func setupRulesLabel() {
        let rules = UILabel()
        rules.numberOfLines = 0
        rules.text = "Эта игра поможет вам потренировать ваш мозг на внимательность. \n Правила просты: Вам нужно найти одинаковые карточки за наименьшее количество времени. Ставьте новые рекорды, удачи!"
        rules.textAlignment = .center
        
        rules.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        rulesLabel = rules
        addSubview(rulesLabel)
        rulesLabelLayout.initial(rulesLabel, to: titleLabel)
    }
    
    private func setupCountControl() {
        let config = CountControl.Customization.BoundedCustomization(
            countTextFont: UIFont.systemFont(ofSize: 17, weight: .bold),
            countTextColor: UIColor(red: 181/255, green: 234/255, blue: 215/255, alpha: 1.0),
            addFirstTextFont: UIFont.systemFont(ofSize: 17, weight: .bold),
            addFirstTextColor: UIColor(red: 181/255, green: 234/255, blue: 215/255, alpha: 1.0),
            buttonsColor: UIColor(red: 181/255, green: 234/255, blue: 215/255, alpha: 1.0),
            backgroundColor: .none,
            countPostfix: .none,
            maxCount: 3, firstButtonText: "Выберите сложность"
        )
        
        let countControl = CountControl(customization: .bounded(config))
        self.levelCountControl = countControl
        self.levelCountControl.addTarget(self, action: #selector(addFirstDidTouch), for: .valueChanged)
        self.levelCountControl.addTarget(self, action: #selector(increaseDidTap), for: .increased)
        self.levelCountControl.addTarget(self, action: #selector(decreaseDidTap), for: .decreased)
        self.levelCountControl.layer.borderWidth = 2
        
        addSubview(self.levelCountControl)
        levelCountControlLayout.initial(self.levelCountControl, to: rulesLabel)
        
        self.levelCountControl.layer.cornerRadius = 25
    }
    
    private func setupCircularProgress() {
        let customizationConfig = CircularProgressView.Customization(
            strokeFillColor: UIColor(red: 181/255, green: 234/255, blue: 215/255, alpha: 1.0).cgColor,
            strokeBaseColor: UIColor(red: 226/255, green: 240/255, blue: 203/255, alpha: 1.0).cgColor,
            fillColor: UIColor.white.cgColor,
            lineWidth: 4,
            textColor: UIColor(red: 181/255, green: 234/255, blue: 215/255, alpha: 1.0),
            animationDuration: 0.5,
            stepNumber: 3,
            intervalStyle: .progressive,
            valueLabelText: "УРОВЕНЬ"
        )
        
        let circularView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 150, height: 150), customization: customizationConfig)
        
        circularProgress = circularView
        addSubview(circularProgress)
        circularProgressLayout.initial(circularProgress, to: levelCountControl)
    }
    
    
    private func setupLevelDescriptionLabel() {
        let level = UILabel()
        level.numberOfLines = 0
        level.text = ""
        level.textAlignment = .center
        
        level.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        levelDescriptionLabel = level
        addSubview(levelDescriptionLabel)
        levelDescriptionLabelLayout.initial(levelDescriptionLabel, to: circularProgress)
    }
   
    
    private func setupStartButton() {
        let button = FloatingButton(target: self, tapAction: #selector(startGameDidTap))
        button.setBackgroundColor(UIColor(red: 181/255, green: 234/255, blue: 215/255, alpha: 1.0))
        button.labelText = "Старт"
        button.isUserInteractionEnabled = false
        button.alpha = 0.3
        
        self.setupButton = button
        addSubview(setupButton)
        setupButtonLayout.initial(setupButton, to: levelDescriptionLabel)
    }
    
    
    private func updateSubviews() {
        guard let selectedLevel = selectedLevel else {
            setupButton.isUserInteractionEnabled = false
            setupButton.alpha = 0.3
            levelDescriptionLabel.text = ""
            return
        }
        
        switch selectedLevel {
        case .easy:
            levelDescriptionLabel.text = firstLevelDescription()
            setupButton.isUserInteractionEnabled = true
            setupButton.alpha = 1.0
        case .medium:
            levelDescriptionLabel.text = secondLevelDescription()
            setupButton.isUserInteractionEnabled = true
            setupButton.alpha = 1.0
        case.hard:
            levelDescriptionLabel.text = thirdLevelDescription()
            setupButton.isUserInteractionEnabled = true
            setupButton.alpha = 1.0
        }
    }
    
    private func firstLevelDescription() -> String {
        return "1 уровень предназначен для новичков. На данном уровне вам необходимо найти 4 пары одинаковых картинок."
    }
    
    private func secondLevelDescription() -> String {
        return "2 уровень требует немного больших усилий. Найдите 6 пар одинаковых картинок"
    }
    
    private func thirdLevelDescription() -> String {
        return "3 уровень предназначен для любителей трудностей. 8 различных вариантов теперь усложняет и то что существует по 3 одинаковых изображения"
    }
    
    @objc private func startGameDidTap() {
        
        delegate?.startButtonDidTouch(with: selectedLevel!)
    }
    
    
    @objc private func addFirstDidTouch() {
        circularProgress.updateProgressView(value: 1)
        selectedLevel = .easy
    }
    
    @objc private func increaseDidTap() {
        circularProgress.updateProgressView(value: 1)
        
        switch levelCountControl.count {
        case 0:
            self.selectedLevel = .none
        case 1:
            self.selectedLevel = .easy
        case 2:
            self.selectedLevel = .medium
        case 3:
            self.selectedLevel = .hard
        default:
            break
        }
    }
    
    @objc private func decreaseDidTap() {
        circularProgress.updateProgressView(value: -1)
        switch levelCountControl.count {
        case 0:
            self.selectedLevel = .none
        case 1:
            self.selectedLevel = .easy
        case 2:
            self.selectedLevel = .medium
        case 3:
            self.selectedLevel = .hard
        default:
            break
        }
        
    }
    
}
