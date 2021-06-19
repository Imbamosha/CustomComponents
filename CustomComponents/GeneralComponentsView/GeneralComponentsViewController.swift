//
//  GeneralComponentsViewController.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 27.03.2021.
//

import UIKit

class GeneralComponentsViewController: UIViewController {
    
    private weak var circularProgressView: CircularProgressView!
    private weak var progressCountControl: CountControl!
    private weak var progressViewSeparator: UIView!
    
    private weak var codeStackView: PhoneCodeView!
    private weak var codeStackViewSeparator: UIView!
    
    private weak var ratingStackView: StarRatingView!
    private weak var ratingSetupTextField: TextFieldWithPadding!
    private weak var ratingSetupButton: FloatingButton!
    private weak var ratingViewSeparator: UIView!
    
    
    private let circularProgressViewLayout = GeneralComponentsViewControllerLayouts.CircularProgressViewLayout()
    private let progressCountControlLayout = GeneralComponentsViewControllerLayouts.CountControlViewLayout()
    private let codeStackViewLayout = GeneralComponentsViewControllerLayouts.CodeStackViewLayout()
    private let ratingStackViewLayout = GeneralComponentsViewControllerLayouts.RatingStackViewLayout()
    private let ratingSetupTextFieldLayout = GeneralComponentsViewControllerLayouts.RatingSetupTextFieldLayout()
    private let ratingSetupButtonLayout = GeneralComponentsViewControllerLayouts.RatingSetupButtonLayout()
    
    private let separatorViewLayout = GeneralComponentsViewControllerLayouts.SeparatorViewLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension GeneralComponentsViewController {
    
    private func setupSubviews() {
        view.backgroundColor = .white
        
        setupCircularProgressView()
        setupCountControl()
        setupCodeStack()
        setupRatingStack()
        setupRatingSetupTextField()
        setupRatingSetupButton()
    }
    
    private func setupCircularProgressView() {

        let customizationConfig = CircularProgressView.Customization(
            strokeFillColor: UIColor(red: 181/255, green: 234/255, blue: 215/255, alpha: 1.0).cgColor,
            strokeBaseColor: UIColor(red: 226/255, green: 240/255, blue: 203/255, alpha: 1.0).cgColor,
            fillColor: UIColor.white.cgColor,
            lineWidth: 4,
            textColor: UIColor(red: 181/255, green: 234/255, blue: 215/255, alpha: 1.0),
            animationDuration: 0.5,
            stepNumber: 10,
            intervalStyle: .progressive,
            valueLabelText: "УРОВЕНЬ"
        )
        
        let circularView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 150, height: 150), customization: customizationConfig)
        
        circularProgressView = circularView
        view.addSubview(circularProgressView)
        circularProgressViewLayout.initial(circularProgressView)
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
            maxCount: 10, firstButtonText: nil
        )

        let countControl = CountControl(customization: .bounded(config))
        self.progressCountControl = countControl
        self.progressCountControl.addTarget(self, action: #selector(addFirstDidTouch), for: .valueChanged)
        self.progressCountControl.addTarget(self, action: #selector(increaseDidTap), for: .increased)
        self.progressCountControl.addTarget(self, action: #selector(decreaseDidTap), for: .decreased)
        self.progressCountControl.layer.borderWidth = 2
        
        view.addSubview(self.progressCountControl)
        progressCountControlLayout.initial(self.progressCountControl, to: circularProgressView)
        
        self.progressCountControl.layer.cornerRadius = 25
        
        setupProgressSeparator()
    }
    
    private func setupProgressSeparator() {
        let separator = UIView()
        
        separator.backgroundColor = UIColor(red: 181/255, green: 234/255, blue: 215/255, alpha: 0.8)
        
        progressViewSeparator = separator
        view.addSubview(progressViewSeparator)
        separatorViewLayout.initial(progressViewSeparator, to: progressCountControl)
    }
    
    private func setupCodeStack() {

        let codeStack = PhoneCodeView(withButton: false)
        self.codeStackView = codeStack
        view.addSubview(self.codeStackView)
//        let codeStack = PhoneCodeStackView(customization: PhoneCodeStackView.Customization(count: 5, borderColor: .red))
//        self.codeStackView = codeStack
//        view.addSubview(self.codeStackView)
        codeStackViewLayout.initial(self.codeStackView, to: progressCountControl)

//        self.codeStackView = codeStack
//        view.addSubview(self.codeStackView)
//        codeStackViewLayout.initial(self.codeStackView, to: progressCountControl)

        setupCodeStackSeparator()
    }
    
    private func setupCodeStackSeparator() {
        let separator = UIView()
        
        separator.backgroundColor = UIColor(red: 181/255, green: 234/255, blue: 215/255, alpha: 0.8)
        
        codeStackViewSeparator = separator
        view.addSubview(codeStackViewSeparator)
        separatorViewLayout.initial(codeStackViewSeparator, to: codeStackView)
    }
    
    private func setupRatingStack() {
        let customization = StarRatingView.Customization(
            fillImage: UIImage(named: "fillHeart")!,
            halfImage: UIImage(named: "fillHeart")!,
            emptyImage: UIImage(named: "fillHeart")!,
            spacing: 5,
            fillTintColor: .black,
            maximumValue: 5
        )

        let rating = StarRatingView(customization: customization)
      
        self.ratingStackView = rating
        view.addSubview(self.ratingStackView)
        ratingStackViewLayout.initial(self.ratingStackView, to: self.codeStackView)
    }
    
    private func setupRatingSetupTextField() {
        let textField = TextFieldWithPadding()
       
        textField.placeholder = "Введите рейтинг"
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 0.5
        textField.layer.masksToBounds = true
        textField.textContentType = .creditCardNumber
        textField.delegate = self
        
        ratingSetupTextField = textField
        view.addSubview(self.ratingSetupTextField)
        ratingSetupTextFieldLayout.initial(ratingSetupTextField, to: ratingStackView)
    }
    
    private func setupRatingSetupButton() {
        let button = FloatingButton(target: self, tapAction: #selector(setupRatingDidTap))
        button.labelText = "Изменить"
        button.setBackgroundColor(UIColor.red)
        ratingSetupButton = button
        
        view.addSubview(ratingSetupButton)
        ratingSetupButtonLayout.initial(ratingSetupButton, to: ratingSetupTextField)
        
        setupRatingViewSeparator()
    }
    
    private func setupRatingViewSeparator() {
        let separator = UIView()
        
        separator.backgroundColor = UIColor(red: 181/255, green: 234/255, blue: 215/255, alpha: 0.8)
        
        ratingViewSeparator = separator
        view.addSubview(ratingViewSeparator)
        separatorViewLayout.initial(ratingViewSeparator, to: ratingSetupButton)
    }
    
}

// MARK: - Actions
extension GeneralComponentsViewController {
    
    @objc private func addFirstDidTouch() {
        circularProgressView.updateProgressView(value: 1)
    }
    
    @objc private func increaseDidTap() {
        circularProgressView.updateProgressView(value: 1)
    }
    
    @objc private func decreaseDidTap() {
        circularProgressView.updateProgressView(value: -1)
    }
    
    @objc private func setupRatingDidTap() {
        if let value = Double(ratingSetupTextField.text ?? "0"), value >= 0 {
            ratingStackView.value = value
        }
    }
    
}

extension GeneralComponentsViewController: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let newCharacters = CharacterSet(charactersIn: string)

        let boolIsNumber = CharacterSet.decimalDigits.isSuperset(of: newCharacters)
        if boolIsNumber == true {
            return true
        } else {
            if string == "."{
                let countdots = (textField.text?.components(separatedBy: ".").count)! - 1
                if countdots == 0 {
                    return true
                } else {
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            } else {
                return false
            }
        }
    }
}

extension GeneralComponentsViewController: CodeStackViewDelegate {
    
    func didTapNextButton(code: String) {
        
    }
    
}
