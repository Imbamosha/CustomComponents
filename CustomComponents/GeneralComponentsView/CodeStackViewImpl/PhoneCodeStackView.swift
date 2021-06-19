//
//  PhoneCodeStackView.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 11.04.2021.
//

import UIKit

protocol PhoneCodeStackViewDelegate: AnyObject {
    
    func textFieldChanged(text: String)
}

class PhoneCodeStackView: UIStackView {
    
    struct Customization {
        let count: Int
        let borderColor: UIColor
    }
    
    private let customization: Customization!
    
    init(customization: PhoneCodeStackView.Customization) {
        self.customization = customization
        super.init(frame: CGRect.zero)
        setupSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        arrangedSubviews.forEach { $0.layer.cornerRadius = $0.bounds.height / 2 }
    }
    
    weak var delegate: PhoneCodeStackViewDelegate?
    
}

//MARK: - Private methods
extension PhoneCodeStackView {
    
    private func setupSubviews() {
        setupCodeStackView()
    }
    
    private func setupCodeStackView() {
        distribution = .fillEqually
        spacing = 5
        axis = .horizontal
        backgroundColor = .clear
        arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for _ in 0..<customization.count {
            let codeTextField = CodeTextField()
            
            codeTextField.layer.borderWidth = 1
            codeTextField.layer.borderColor = customization.borderColor.cgColor
            codeTextField.keyboardType = .numberPad
            codeTextField.backgroundColor = .white
            codeTextField.textAlignment = .center
            
            if #available(iOS 12.0, *) {
                codeTextField.textContentType = .oneTimeCode
            }
            codeTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            
            codeTextField.delegate = self
            
            codeTextField.translatesAutoresizingMaskIntoConstraints = false
            
            addArrangedSubview(codeTextField)
            
            codeTextField.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
            codeTextField.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
            codeTextField.heightAnchor.constraint(equalTo: codeTextField.widthAnchor).isActive = true
        }
    }
}


extension PhoneCodeStackView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldIndex = arrangedSubviews.firstIndex(of: textField) ?? 0
        // удаление элемента
        if string == "" {
            //текущие поле пустое и нужно переходить на следующие поле слева
            if textField.text == "" || textField.text == nil {
                // есть ли слева еще поля
                if textFieldIndex > 0 {
                    let previousTextField = arrangedSubviews[textFieldIndex - 1] as? UITextField
                    previousTextField?.text = string
                    previousTextField?.becomeFirstResponder()
                } else {
                    return false
                }
                return false
            } else {
                return true
            }
        } else {
            if textFieldIndex < customization.count - 1 {
                let nextTextField = arrangedSubviews[textFieldIndex + 1] as? UITextField
                textField.text = string
                nextTextField?.becomeFirstResponder()
                return false
            } else {
                textField.text = string
                textField.resignFirstResponder()
                return true
            }
        }
        delegate?.textFieldChanged(text: string)
    }
   
}

