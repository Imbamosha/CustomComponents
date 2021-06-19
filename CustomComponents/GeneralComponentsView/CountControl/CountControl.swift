//
//  CountControl.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 27.03.2021.
//

import UIKit

struct CountControlState: OptionSet {

    let rawValue: Int

    static let empty    = CountControlState(rawValue: 1 << 0)
    static let counting = CountControlState(rawValue: 1 << 1)

}

class CountControl: UIControl {

    enum Customization {
        struct BoundedCustomization {
            let countTextFont: UIFont
            let countTextColor: UIColor
            let addFirstTextFont: UIFont
            let addFirstTextColor: UIColor
            let buttonsColor: UIColor
            let backgroundColor: UIColor?
            let countPostfix: String?
            let maxCount: Int
            let firstButtonText: String?
        }
        
        case bounded(BoundedCustomization)
    }

    private let customization: CountControl.Customization

    private var addFirstLabel: UILabel?
    private var addFirstButton: UIButton?

    private var incrementImageView: UIImageView?
    private var incrementButton: UIButton?

    private var decrementImageView: UIImageView?
    private var decrementButton: UIButton?

    private var counterLabel: UILabel?

    private var countPostfix: String?

    var controlState: CountControlState {
        didSet {
            if oldValue != controlState {
               updateView()
            }
        }
    }

    var count: Int {
        didSet {
            if oldValue != count {
                if let countPostfix = self.countPostfix {
                    counterLabel?.text = "\(count) \(countPostfix)"
                } else {
                    counterLabel?.text = "\(count)"
                }
            }
            if count <= 0 {
                controlState = .empty
            } else {
                controlState = .counting
            }
        }
    }


    init(frame: CGRect, customization: CountControl.Customization) {
        self.customization = customization
        self.controlState = .empty
        self.count = 0

        super.init(frame: frame)

        setupView()
    }

    convenience init(customization: CountControl.Customization) {
        self.init(frame: .zero, customization: customization)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Private Methods - Setup
extension CountControl {

    private func setupView() {
        setupCountLabel()
        setupButtons()
        setupButtonsLabels()
        setupAddFirstButton()

        switch customization {
        case let .bounded(config):
            customizeBounded(customization: config)
        }

        incrementImageView?.isHidden = true
        incrementButton?.isHidden = true
        decrementImageView?.isHidden = true
        decrementButton?.isHidden = true
        counterLabel?.isHidden = true
        addFirstButton?.isHidden = false
        addFirstLabel?.isHidden = false

        layoutIfNeeded()
    }

    private func setupButtonsLabels() {
        incrementImageView = UIImageView(image: UIImage(named: "plus"))
        incrementImageView?.contentMode = .scaleAspectFit
        incrementImageView?.backgroundColor = .clear

        decrementImageView = UIImageView(image: UIImage(named: "minus"))
        decrementImageView?.contentMode = .scaleAspectFit
        decrementImageView?.backgroundColor = .clear

        addSubview(incrementImageView!)
        addSubview(decrementImageView!)

        incrementImageView?.translatesAutoresizingMaskIntoConstraints = false
        decrementImageView?.translatesAutoresizingMaskIntoConstraints = false

        decrementImageView?.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        decrementImageView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        decrementImageView?.centerXAnchor.constraint(equalTo: decrementButton!.centerXAnchor).isActive = true

        incrementImageView?.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        incrementImageView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        incrementImageView?.centerXAnchor.constraint(equalTo: incrementButton!.centerXAnchor).isActive = true

    }

    private func setupButtons() {
        incrementButton = UIButton()
        decrementButton = UIButton()
        addFirstButton = UIButton()

        addFirstButton?.addTarget(self, action: #selector(addFirstDidTap), for: .touchUpInside)
        incrementButton?.addTarget(self, action: #selector(increaseDidTap), for: .touchUpInside)
        decrementButton?.addTarget(self, action: #selector(decreaseDidTap), for: .touchUpInside)

        addSubview(incrementButton!)
        addSubview(decrementButton!)
        addSubview(addFirstButton!)

        incrementButton?.translatesAutoresizingMaskIntoConstraints = false
        decrementButton?.translatesAutoresizingMaskIntoConstraints = false
        addFirstButton?.translatesAutoresizingMaskIntoConstraints = false

        decrementButton?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        decrementButton?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        decrementButton?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        decrementButton?.trailingAnchor.constraint(equalTo: counterLabel!.leadingAnchor).isActive = true

        incrementButton?.leadingAnchor.constraint(equalTo: counterLabel!.trailingAnchor).isActive = true
        incrementButton?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        incrementButton?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        incrementButton?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        addFirstButton?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        addFirstButton?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        addFirstButton?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        addFirstButton?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }


    private func setupCountLabel() {
        counterLabel = UILabel()
        counterLabel?.textAlignment = .center

        addSubview(counterLabel!)

        counterLabel?.translatesAutoresizingMaskIntoConstraints = false

        counterLabel?.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33).isActive = true
        counterLabel?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        counterLabel?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    private func setupAddFirstButton() {
        addFirstLabel = UILabel()
        
        switch customization {
        case let .bounded(config):
            addFirstLabel?.text = config.firstButtonText ?? "Добавить"
        default:
            addFirstLabel?.text = "Добавить"
        }
        
        
        addFirstLabel?.textAlignment = .center
        addFirstLabel?.backgroundColor = .clear

        addSubview(addFirstLabel!)

        addFirstLabel?.translatesAutoresizingMaskIntoConstraints = false

        addFirstLabel?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        addFirstLabel?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        addFirstLabel?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        addFirstLabel?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func customizeBounded(customization: Customization.BoundedCustomization) {
        countPostfix = customization.countPostfix
        counterLabel?.font = customization.countTextFont
        counterLabel?.textColor = customization.countTextColor

        addFirstLabel?.font = customization.addFirstTextFont
        addFirstLabel?.textColor = customization.addFirstTextColor

        decrementImageView?.tintColor = customization.buttonsColor
        incrementImageView?.tintColor = customization.buttonsColor
        self.layer.borderColor = customization.buttonsColor.cgColor
    }

}

// MARK: - Private Methods - Update
extension CountControl {

    private func updateView() {
        switch customization {
        case let .bounded(config):
            switch controlState {
            case .empty:
                backgroundColor = .clear
            case .counting:
                if let buttonBackgroundColor = config.backgroundColor {
                    backgroundColor = config.buttonsColor
                    incrementImageView?.tintColor = buttonBackgroundColor
                    decrementImageView?.tintColor = buttonBackgroundColor
                    counterLabel?.textColor = buttonBackgroundColor
                }
            default:
                break
            }
            
        }
        subviews.forEach {
            $0.isHidden.toggle()
        }
    }

}

// MARK: - Actions
extension CountControl {

    @objc private func addFirstDidTap() {
        sendActions(for: .valueChanged)
        controlState = .counting
        count += 1
    }

    @objc private func increaseDidTap() {
        switch customization {
        case let .bounded(config):
            if count < config.maxCount {
                count += 1
                sendActions(for: .increased)
            }
        }
    }

    @objc private func decreaseDidTap() {
        if count != 0  {
            count -= 1
        } else {
            controlState = .empty
        }
        sendActions(for: .decreased)
    }

}

extension UIControl.Event {
    static var increased: UIControl.Event { return UIControl.Event(rawValue: 0b0001 << 24) }
    static var decreased: UIControl.Event { return UIControl.Event(rawValue: 0b0010 << 24) }
}
