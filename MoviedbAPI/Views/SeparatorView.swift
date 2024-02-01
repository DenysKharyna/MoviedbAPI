//
//  SeparatorView.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 01.02.2024.
//

import UIKit

final class SeparatorView: UIView {
    // MARK: Life cycle
    init(frame: CGRect, bgColor: UIColor) {
        super.init(frame: frame)
        configureView(with: bgColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    private func configureView(with color: UIColor) {
        backgroundColor = color
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30).isActive = true
        heightAnchor.constraint(equalToConstant: 1).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
