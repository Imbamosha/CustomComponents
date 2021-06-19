//
//  CodeTextField.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 29.03.2021.
//

import UIKit

class CodeTextField: UITextField {
    
    override func deleteBackward() {
        super.deleteBackward()
        delegate?.textField?(self, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "")
    }
    
}
