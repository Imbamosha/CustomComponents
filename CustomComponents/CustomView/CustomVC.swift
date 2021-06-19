//
//  CustomVC.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 12.05.2021.
//

import Foundation
import UIKit
import SnapKit

class CustomVC: UIViewController {
    
    private weak var dateAndTimeLabel: UIView!
    
    private weak var phoneTextField: PhoneTextField!
    private weak var phoneAcceptButton: UIButton!
    
    private weak var urlTextField: UITextField!
    private weak var urlAcceptButton: UIButton!
    
    private weak var openFragmentsButton: FloatingButton!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupDateAndTime()
        setupPhoneTextField()
        setupURLTextField()
        setupFragmentsButton()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
}

extension CustomVC {
    
    private func setupDateAndTime() {
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)
    
        dateAndTimeLabel = label
        view.addSubview(dateAndTimeLabel)
        
        dateAndTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(40)
            $0.trailing.equalTo(-40)
            $0.height.equalTo(60)
        }
    }
    
    private func setupPhoneTextField() {
        let phone = PhoneTextField()
        phone.phone = nil
        phone.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        phone.textColor = UIColor.darkGray
        phone.regionCode = 7
        phone.delegate = self
        view.addSubview(phone)
        
        phoneTextField = phone
        
        phoneTextField.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(70)
            $0.top.equalTo(dateAndTimeLabel.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
        }
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "nextLoginButton"), for: .normal)
        button.isUserInteractionEnabled = false
        button.alpha = 0.4
        
        button.addTarget(self, action: #selector(phoneButtonDidTouch), for: .touchUpInside)
        phoneAcceptButton = button
        view.addSubview(phoneAcceptButton)
        
        phoneAcceptButton.snp.makeConstraints {
            $0.top.bottom.equalTo(phoneTextField)
            $0.trailing.equalToSuperview().offset(-50)
            $0.width.equalTo(70)
        }
        
    }
    
    @objc private func phoneButtonDidTouch() {
        if let url = URL(string: "tel://+7" + phoneTextField.phone!),
           UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    private func setupURLTextField() {
        let textField = TextFieldWithPadding()
       
        textField.placeholder = "Введите URL"
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 0.5
        textField.layer.masksToBounds = true
        textField.textColor = .black
        textField.textContentType = .URL
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        urlTextField = textField
        view.addSubview(urlTextField)
        
        urlTextField.snp.makeConstraints {
            $0.width.equalTo(250)
            $0.height.equalTo(70)
            $0.top.equalTo(dateAndTimeLabel.snp.bottom).offset(200)
            $0.leading.equalToSuperview().offset(40)
        }
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "nextLoginButton"), for: .normal)
        button.isUserInteractionEnabled = false
        button.alpha = 0.4
        
        button.addTarget(self, action: #selector(urlButtonDidTouch), for: .touchUpInside)
        urlAcceptButton = button
        view.addSubview(urlAcceptButton)
        
        urlAcceptButton.snp.makeConstraints {
            $0.top.bottom.equalTo(urlTextField)
            $0.trailing.equalToSuperview().offset(-30)
            $0.width.equalTo(70)
        }
    }
    
    @objc private func urlButtonDidTouch() {
        if let url = URL(string: "https://" + urlTextField.text!) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func textFieldDidChange() {
        if urlTextField.text != " " || urlTextField.text != nil {
            urlAcceptButton.isUserInteractionEnabled = true
            urlAcceptButton.alpha = 1.0
        } else {
            urlAcceptButton.isUserInteractionEnabled = false
            urlAcceptButton.alpha = 0.4
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    private func setupFragmentsButton() {
        let button = FloatingButton(target: self, tapAction: #selector(openFragmentsDidTap))
        button.labelText = "Открыть Fragments"
        
        openFragmentsButton = button
        
        view.addSubview(openFragmentsButton)
        
        openFragmentsButton.snp.makeConstraints {
            $0.top.equalTo(urlTextField.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(52)
        }
        
        
    }
    
    @objc func openFragmentsDidTap() {
        self.present(FragmentsVC(), animated: true, completion: nil)
    }
}


extension CustomVC: PhoneTextFieldDelegate {
    
    func phoneTextFieldDidChangePhone(
        _ phoneTextField: PhoneTextField
    ) {
        if phoneTextField.phone?.count == 10 {
            phoneAcceptButton.isUserInteractionEnabled = true
            phoneAcceptButton.alpha = 1.0
        } else {
            phoneAcceptButton.isUserInteractionEnabled = false
            phoneAcceptButton.alpha = 0.4
        }
    }
}

extension CustomVC: UITextFieldDelegate {
    
}
