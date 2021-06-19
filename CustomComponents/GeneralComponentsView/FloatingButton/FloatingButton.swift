//
//  FloatingButton.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 08.04.2021.
//

import UIKit
import SnapKit

class FloatingButton: UIView {
    
    private weak var label: UILabel!
    
    var labelText: String? {
        get { return label.text }
        set { label.text = newValue }
    }
    
    init(target: Any?, tapAction: Selector) {
        super.init(frame: CGRect.zero)
        addGestureRecognizer(UITapGestureRecognizer(target: target, action: tapAction))
        setupSubviews()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Override methods
extension FloatingButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.layer.cornerRadius = frame.height / 2
    }
    
    override func touchesBegan(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        DispatchQueue.main.async {
            self.alpha = 1.0
            UIView.animate(
                withDuration: 0.2,
                delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                    self.alpha = 0.5
                },
                completion: nil
            )
        }
    }
    
    override func touchesEnded(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(
                withDuration: 0.2,
                delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    self.transform = CGAffineTransform.identity
                    self.alpha = 1.0
                },
                completion: nil
            )
        }
    }
    
    override func touchesCancelled(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(
                withDuration: 0.2,
                delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    self.transform = CGAffineTransform.identity
                    self.alpha = 1.0
                },
                completion: nil
            )
        }
    }
    
}

//MARK: - Public methods
extension FloatingButton {
    
    func setBackgroundColor(_ color: UIColor) {
        label.backgroundColor = color
    }

}

//MARK: - Private methods
extension FloatingButton {
    
    private func setupSubviews() {
        isUserInteractionEnabled = true
        backgroundColor = .clear
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.backgroundColor = .red
        label.textColor = .white
        label.textAlignment = .center
        label.clipsToBounds = true
        
        self.label = label
        addSubview(self.label)
        
        self.label.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        customizeButtonLayer()
    }
    
    private func customizeButtonLayer() {
        //Рассказать про корнер радиус + тень
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
}
