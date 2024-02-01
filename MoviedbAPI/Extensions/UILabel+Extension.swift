//
//  UILabel+Extension.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 01.02.2024.
//

import UIKit

extension UILabel {
    func titleTextStyle(text: String = "", fontSize: CGFloat = 22) {
        self.text = text
        font = .systemFont(ofSize: fontSize, weight: .semibold)
        textColor = .label
        numberOfLines = 0
        lineBreakStrategy = .hangulWordPriority
    }
    
    func setLineSpacing(_ lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        guard let labelText = text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        attributedText = attributedString
    }
}
