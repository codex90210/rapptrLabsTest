//
//  UIExtensions.swift
//  Rapptr iOS Test
//
//  Created by David Mompoint on 12/28/21.
//

import Foundation
import UIKit

//MARK: - Button Theme for Coding Tasks
func buttonTheme(buttons: [UIButton]) {
    
    for button in buttons {
        button.backgroundColor = .init(white: 1.0, alpha: 0.8)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        button.tintColor = .black
        button.imageEdgeInsets.left = 22
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets.left = 16 + 24
    
    }
}

//MARK: - Fade in & Log in Button
func blueButtonTheme(button: UIButton) {
    
    button.backgroundColor = .headerColor
    button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .semibold)
    button.tintColor = .white
    button.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
}

//MARK: - textField Settings
func userEntryFieldSettings(textField: [UITextField]) {
    
    for entries in textField {
        
        entries.backgroundColor = .init(white: 1.0, alpha: 0.8)
        entries.layer.cornerRadius = 8
        entries.layer.masksToBounds = true
        entries.font = .systemFont(ofSize: 16, weight: .regular)
        entries.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
        
    }
}

//MARK: - Custom UIColors
extension UIColor {
    
    // grey
    static let chatBorderColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
    
    // light grey
    static let viewColor = UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
    
    // blue
    static let headerColor = UIColor(red: 14.0/255.0, green: 92.0/255.0, blue: 137.0/255.0, alpha: 1.0)
    
    // dark
    static let chatTextColor = UIColor(red: 27.0/255.0, green: 30.0/255.0, blue: 31.0/255.0, alpha: 1.0)
    
    // greyish
    static let loginPlacholderColor = UIColor(red: 95.0/255.0, green: 96.0/255.0, blue: 99.0/255.0, alpha: 1.0)
}

//MARK: - Draggable UI Effect
class dragImage: UIImageView {
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touched = touches.first {
            let position = touched.location(in: superview)
            center = CGPoint(x: position.x, y: position.y)
        }
    }
}

//MARK: - textField Custom Insets
@IBDesignable
class TextField: UITextField {
    @IBInspectable var xInset: CGFloat = 0.0
    @IBInspectable var yInset: CGFloat = 0.0
    
    // place holder
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: xInset, dy: yInset)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: xInset, dy: yInset)
    }
}
