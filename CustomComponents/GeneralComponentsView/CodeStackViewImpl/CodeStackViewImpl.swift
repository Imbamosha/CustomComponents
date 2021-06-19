//
//  CodeStackViewImpl.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 29.03.2021.
//

import UIKit

class CodeStackViewImpl: UIStackView {
    
    var delegate: CodeStackViewDelegate?
    
    private var isFilledCode: Bool = false
    private var stackWithButton: Bool = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        arrangedSubviews.forEach { $0.layer.cornerRadius = $0.bounds.height / 2 }
    }
    
}

// MARK: Interface
extension CodeStackViewImpl: CodeStackView {
    
    var hasButton: Bool {
        get {
            return stackWithButton
        }
        set {
            stackWithButton = newValue
            setupCodeStack(countElements: countElements, withButton: newValue)
        }
    }
    
    var countElements: Int {
        get {
            return arrangedSubviews.count
        }
        set {
            setupCodeStack(countElements: newValue, withButton: stackWithButton)
        }
    }
    
    var elementsValue: String  {
        
        get {
            var values = ""
            arrangedSubviews.forEach {
                values += ($0 as? UITextField)?.text ?? ""
            }
            return values
        }
        
    }
    
    
}


//MARK: - Private methods
extension CodeStackViewImpl {
    
    private func setupCodeStack(countElements: Int, withButton: Bool) {
        distribution = .fillEqually
        spacing = 5
        axis = .horizontal
        backgroundColor = .clear
        arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for _ in 0..<countElements - 1 {
            let codeTextField = CodeTextField()
            
            codeTextField.layer.borderWidth = 1
            codeTextField.layer.borderColor = UIColor.red.cgColor
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
    
    private func setupNextButton() {
        let nextButton = UIButton()
        nextButton.alpha = 0.2
        nextButton.setImage(UIImage(named: "nextLoginButton"), for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.heightAnchor.constraint(equalTo: nextButton.widthAnchor).isActive = true
        nextButton.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        nextButton.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        
        addArrangedSubview(nextButton)
        
        arrangedSubviews.first?.becomeFirstResponder()
    }
    
    private func codeFilledAction(allFilled: Bool) {
        isFilledCode = allFilled
        
        guard let nextButton = arrangedSubviews.last else { return }
        if isFilledCode {
            nextButton.alpha = 1
            delegate?.didTapNextButton(code: getCode())
        } else {
            nextButton.alpha = 0.2
        }
    }
    
    private func getCode() -> String {
        let code = arrangedSubviews.map { (($0 as? UITextField)?.text ?? "") }.joined()
        return code
    }
    
}

//MARK: - Actions
extension CodeStackViewImpl {
    
    //MARK: - Action
    @objc private func nextButtonAction() {
        delegate?.didTapNextButton(code: getCode())
    }
}

//MARK: UITextFieldDelegate
extension CodeStackViewImpl: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldIndex = arrangedSubviews.firstIndex(of: textField) ?? 0
        
        // удаление элемента
        if string == "" {
            codeFilledAction(allFilled: false)
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
            //Если есть в стеке кнопка то ее не учитывать в работе с полями ввода
            if stackWithButton {
                if textFieldIndex < countElements - 2 {
                    let nextTextField = arrangedSubviews[textFieldIndex + 1] as? UITextField
                    textField.text = string
                    nextTextField?.becomeFirstResponder()
                    return false
                } else {
                    textField.text = string
                    textField.resignFirstResponder()
                    codeFilledAction(allFilled: true)
                }
            } else {
                if textFieldIndex < countElements - 1 {
                    let nextTextField = arrangedSubviews[textFieldIndex + 1] as? UITextField
                    textField.text = string
                    nextTextField?.becomeFirstResponder()
                    return false
                } else {
                    codeFilledAction(allFilled: true)
                    textField.text = string
                    textField.resignFirstResponder()
                }
            }
            
        }
        return true
    }
    
}
