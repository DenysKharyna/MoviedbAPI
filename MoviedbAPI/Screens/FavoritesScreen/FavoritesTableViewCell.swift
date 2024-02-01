//
//  FavoritesTableViewCell.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 01.02.2024.
//

import UIKit

final class FavoritesTableViewCell: UITableViewCell {
    // MARK: Properties
    private let moviePosterImage = MoviePosterImage()
    private let movieTitleLabel = UILabel()
    private let movieGenresLabel = UILabel()
    private let movieReleaseDateLabel = UILabel()
    
    // MARK: Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        constrain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Helpers
    func configure(with viewModel: FavoritesCellViewModel) {
        if let imageData = viewModel.moviePosterData {
            moviePosterImage.imageView.image = UIImage(data: imageData)
        }
        movieTitleLabel.text = viewModel.movieTitle
        movieGenresLabel.text = viewModel.movieGenres
        movieReleaseDateLabel.text = viewModel.releaseDateText
    }
    private func configureUI() {
        // moviePosterImage
        moviePosterImage.widthAnchor.constraint(equalToConstant: 110).isActive = true
        moviePosterImage.heightAnchor.constraint(equalToConstant: 170).isActive = true
        // movieTitleLabel
        movieTitleLabel.titleTextStyle(fontSize: 20)
        // movieGenresLabel
        movieGenresLabel.font = .systemFont(ofSize: 16, weight: .medium)
        movieGenresLabel.lineBreakStrategy = .hangulWordPriority
        movieGenresLabel.textColor = .secondaryLabel
        movieGenresLabel.numberOfLines = 0
        // movieReleaseDateLabel
        movieReleaseDateLabel.font = .systemFont(ofSize: 15)
        movieReleaseDateLabel.textColor = .secondaryLabel
    }
    
    private func constrain() {
        // infoStack
        let infoStack = UIStackView(arrangedSubviews: [movieTitleLabel, movieGenresLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 5
        // allTextStack
        let allTextStack = UIStackView(arrangedSubviews: [infoStack, movieReleaseDateLabel])
        allTextStack.axis = .vertical
        allTextStack.spacing = 30
        // MainStack
        let mainStack = UIStackView(arrangedSubviews: [moviePosterImage, allTextStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 20
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainStack.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}
