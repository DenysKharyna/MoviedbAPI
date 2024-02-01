//
//  MoviePosterImage.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 01.02.2024.
//

import UIKit

final class MoviePosterImage: UIView {
    // MARK: Properties
    var imageView = UIImageView()
    
    // MARK: Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        configureView()
    }
    
    // MARK: Helper
    private func configureView() {
        clipsToBounds = false
        layer.shadowColor = UIColor.systemGray2.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.45
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        
        imageView.frame = bounds
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
    }
}
