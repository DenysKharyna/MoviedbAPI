//
//  MoviesListCollectionViewCell.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 30.01.2024.
//

import UIKit

final class MoviesListCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    private let movieImage = UIImageView()
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        constrain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    func configure(with viewModel: MoviesListCellViewModel) {
        movieImage.setPosterImage(posterPath: viewModel.movie.posterPath, networkManager: NetworkManager())
    }
    
    private func configureUI() {
        clipsToBounds = false
        layer.shadowColor = UIColor.systemGray2.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.45
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
        
        movieImage.backgroundColor = .systemGray6
        movieImage.layer.cornerRadius = 12
        movieImage.clipsToBounds = true
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieImage)
    }
    
    private func constrain() {
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
