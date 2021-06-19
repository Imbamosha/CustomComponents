//
//  CodeStackView.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 29.03.2021.
//

import UIKit

//Delegate
protocol CodeStackViewDelegate {
    func didTapNextButton(code: String)
}

//Interface
protocol CodeStackView: UIView {
    var countElements: Int { get set }
    var hasButton: Bool { get set }
    var elementsValue: String { get }
    var delegate: CodeStackViewDelegate? { get set }
}
