//
//  PhoneCodeView.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 12.04.2021.
//

import UIKit

class PhoneCodeView: UIView {
    
    private weak var phoneCodeStackView: UIStackView!
    private weak var selectButton: UIButton!
    
    private let phoneCodeStackViewLayout = PhoneCodeViewLayouts.StackViewLayouts()
    private let selectButtonLayout = PhoneCodeViewLayouts.ButtonLayouts()
    
    init(withButton: Bool) {
        super.init(frame: .zero)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension PhoneCodeView {
    
    private func setupSubviews() {
        setupSelectButton()
        setupPhoneCodeStackView()
    }
    
    private func setupPhoneCodeStackView() {
        let stackView = PhoneCodeStackView(customization: PhoneCodeStackView.Customization(count: 5, borderColor: .red))
        stackView.delegate = self
        self.phoneCodeStackView = stackView
        addSubview(phoneCodeStackView)
        phoneCodeStackViewLayout.initial(phoneCodeStackView, to: selectButton)
    }
    
    private func setupSelectButton() {
        let selectButton = UIButton()
        selectButton.setImage(UIImage(named: "nextLoginButton"), for: .normal)
        selectButton.isUserInteractionEnabled = false
        selectButton.alpha = 0.5
        
        self.selectButton = selectButton
        
        addSubview(selectButton)
        selectButtonLayout.initial(selectButton)
    }
    
}

extension PhoneCodeView: PhoneCodeStackViewDelegate {
    
    func textFieldChanged(text: String) {
        if text.count == 5 {
            selectButton.alpha = 1.0
            selectButton.isUserInteractionEnabled = true
        } else {
            selectButton.isUserInteractionEnabled = false
            selectButton.alpha = 0.5
        }
    }
    
    
}
