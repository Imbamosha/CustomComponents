//
//  PhoneTextField.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 13.05.2021.
//

import UIKit


@objc public protocol PhoneTextFieldDelegate: AnyObject {

    @objc optional func phoneTextFieldShouldBeginEditing(
        _ phoneTextField: PhoneTextField
    ) -> Bool

    @objc optional func phoneTextFieldDidBeginEditing(
        _ phoneTextField: PhoneTextField
    )

    @objc optional func phoneTextFieldDidChangePhone(
        _ phoneTextField: PhoneTextField
    )

    @objc optional func phoneTextFieldShouldEndEditing(
        _ phoneTextField: PhoneTextField
    ) -> Bool

    @objc optional func phoneTextFieldDidEndEditing(
        _ phoneTextField: PhoneTextField
    )

}

public class PhoneTextField: UIView {

    private enum OverflowBehaviour {
        case dropFirst
        case dropLast
    }

    private weak var regionCodeLabel: UILabel!
    private weak var digitsTextField: UITextField!

    public override func becomeFirstResponder() -> Bool {
        return digitsTextField.becomeFirstResponder()
    }

    public var regionCode: Int {
        get { unformattedRegionCode(regionCodeLabel.text) }
        set { regionCodeLabel.text = formattedRegionCode(newValue) }
    }

    public var phone: String?  {
        get { unformattedDigits(digitsTextField.text) }
        set { digitsTextField.text = formattedDigits(newValue, overflowBehaviour: .dropFirst) }
    }

    public var font: UIFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize) {
        willSet { setupView() }
    }

    public var textColor: UIColor = UIColor.black {
        willSet { setupView() }
    }

    public weak var delegate: PhoneTextFieldDelegate?

    override public init(
        frame: CGRect
    ) {
        super.init(frame: frame)

        setupView()
    }

    convenience public init() {
        self.init(frame: .zero)

        setupView()
    }

    required init?(
        coder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Setups

extension PhoneTextField {

    private func setupView() {
        setupRegionCodeLabel()
        setupDigitsTextField()

        layoutIfNeeded()
    }

    private func setupRegionCodeLabel() {
        if regionCodeLabel == nil {
            addRegionCodeLabel()
            regionCode = 7
        }

        regionCodeLabel.font = font
        regionCodeLabel.textColor = textColor
    }

    private func addRegionCodeLabel() {
        let regionCodeLabel = UILabel()

        addSubview(regionCodeLabel)

        regionCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        regionCodeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        regionCodeLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        regionCodeLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor).isActive = true
        regionCodeLabel.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor).isActive = true
        regionCodeLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .horizontal)

        self.regionCodeLabel = regionCodeLabel
    }

    private func setupDigitsTextField() {
        if digitsTextField == nil {
            addDigitsTextField()
            digitsTextField.delegate = self
            phone = nil
        }

        digitsTextField.font = font
        digitsTextField.textColor = textColor
        digitsTextField.placeholder = "999) 99-99-99"
        digitsTextField.textContentType = .telephoneNumber
        digitsTextField.keyboardType = .numberPad
    }

    private func addDigitsTextField() {
        let digitsTextField = UITextField()

        addSubview(digitsTextField)

        digitsTextField.translatesAutoresizingMaskIntoConstraints = false
        digitsTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 1).isActive = true
        digitsTextField.leadingAnchor.constraint(equalTo: regionCodeLabel.trailingAnchor).isActive = true
        digitsTextField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        digitsTextField.topAnchor.constraint(greaterThanOrEqualTo: topAnchor).isActive = true
        digitsTextField.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor).isActive = true

        self.digitsTextField = digitsTextField
    }

}

// MARK: - Formatters

extension PhoneTextField {

    private func formattedRegionCode(
        _ code: Int
    ) -> String {
        return String(format: "+%d (", code)
    }

    private func unformattedRegionCode(
        _ code: String?
    ) -> Int {
        guard let code = code else { return 0 }

        return Int(code.filter { "1234567890".contains($0) }) ?? 0
    }

    private func formattedDigits(
        _ digits: String?,
        overflowBehaviour: OverflowBehaviour
    ) -> String? {
        guard var filteredDigits = digits?.filter({ "1234567890".contains($0) }) else { return nil }

        switch (filteredDigits.count, overflowBehaviour) {
        case (0, _):
            return ""
        case (11..., .dropFirst):
            filteredDigits = String(filteredDigits.dropFirst(filteredDigits.count - 10))
        case (11..., .dropLast):
            filteredDigits = String(filteredDigits.dropLast(filteredDigits.count - 10))
        default:
            break
        }

        let phoneFormatPattern = "^(\\d{0,3}){0,1}(\\d{0,3}){0,1}(\\d{0,2}){0,1}(\\d{0,2}){0,1}$"
        let phoneMask: String

        switch filteredDigits.count {
        case 1..<3:
            phoneMask = "$1"
        case 3..<6:
            phoneMask = "$1) $2"
        case 6..<8:
            phoneMask = "$1) $2-$3"
        default:
            phoneMask = "$1) $2-$3-$4"
        }

        return filteredDigits.replacingOccurrences(of: phoneFormatPattern,
                                                   with: phoneMask,
                                                   options: .regularExpression,
                                                   range: nil)
    }

    private func unformattedDigits(
        _ digits: String?
    ) -> String? {
        return digits?.filter { "1234567890".contains($0) }
    }

}

// MARK: - UITextFieldDelegate

extension PhoneTextField: UITextFieldDelegate {

    public func textFieldShouldBeginEditing(
        _ textField: UITextField
    ) -> Bool {
        return delegate?.phoneTextFieldShouldBeginEditing?(self) ?? true
    }

    public func textFieldDidBeginEditing(
        _ textField: UITextField
    ) {
        delegate?.phoneTextFieldDidBeginEditing?(self)
    }

    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        defer {
            delegate?.phoneTextFieldDidChangePhone?(self)
        }

        let oldValue = textField.text ?? ""

        guard
            let range = Range<String.Index>(range, in: oldValue),
            let selectedRange = textField.selectedTextRange
        else { return false }

        let oldCursorPosition = textField.offset(from: textField.beginningOfDocument, to: selectedRange.start)

        let newValue = calculateNewValue(oldValue: oldValue,
                                         oldCursorPosition: oldCursorPosition,
                                         range: range,
                                         string: string)

        let newCursorPosition = calculateNewCursorPosition(oldValue: oldValue,
                                                           newValue: newValue,
                                                           oldCursorPosition: oldCursorPosition)

        textField.text = newValue

        guard
            let newPosition = textField.position(from: textField.beginningOfDocument, offset: newCursorPosition)
        else { return false }

        textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)

        return false
    }

    public func textFieldShouldEndEditing(
        _ textField: UITextField
    ) -> Bool {
        return delegate?.phoneTextFieldShouldEndEditing?(self) ?? true
    }

    public func textFieldDidEndEditing(
        _ textField: UITextField
    ) {
        delegate?.phoneTextFieldDidEndEditing?(self)
    }

}

// MARK: - Helpers

extension PhoneTextField {

    private func calculateNewValue(
        oldValue: String,
        oldCursorPosition: Int,
        range: Range<String.Index>,
        string: String
    ) -> String {
        let newValue = oldValue.replacingCharacters(in: range, with: string)

        guard
            let unformattedNewValue = unformattedDigits(newValue),
            let formattedNewValue = formattedDigits(newValue, overflowBehaviour: .dropLast)
        else { return newValue }

        if formattedNewValue.count == oldValue.count, string.isEmpty {
            switch oldCursorPosition {
            case 4, 5:
                guard
                    let range = Range(NSRange(location: 2, length: 1), in: unformattedNewValue),
                    let correctNewValue = formattedDigits(unformattedNewValue.replacingCharacters(in: range, with: ""),
                                                          overflowBehaviour: .dropLast)
                else { return formattedNewValue }

                return correctNewValue
            case 9:
                guard
                    let range = Range(NSRange(location: 5, length: 1), in: unformattedNewValue),
                    let correctNewValue = formattedDigits(unformattedNewValue.replacingCharacters(in: range, with: ""),
                                                          overflowBehaviour: .dropLast)
                else { return formattedNewValue }

                return correctNewValue
            case 12:
                guard
                    let range = Range(NSRange(location: 7, length: 1), in: unformattedNewValue),
                    let correctNewValue = formattedDigits(unformattedNewValue.replacingCharacters(in: range, with: ""),
                                                          overflowBehaviour: .dropLast)
                else { return formattedNewValue }

                return correctNewValue
            default:
                return formattedNewValue
            }
        } else {
            return formattedNewValue
        }
    }

    private func calculateNewCursorPosition(
        oldValue: String,
        newValue: String,
        oldCursorPosition: Int
    ) -> Int {
        let countDiff = newValue.count - oldValue.count

        switch (countDiff, oldCursorPosition) {
        case (0, 3): return 6
        case (0, 8): return 10
        case (0, 11): return 13
        case (0, 14): return 14
        case (0, _): return oldCursorPosition + 1
        default: return oldCursorPosition + countDiff
        }
    }

}
