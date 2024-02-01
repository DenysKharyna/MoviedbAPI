//
//  MovieDetailsViewController.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 31.01.2024.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    // MARK: Properties
    private let viewModel: MovieDetailsViewModel
    
    private let moviePosterImage = MoviePosterImage()
    private let titleLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let separator = SeparatorView(frame: .zero, bgColor: .systemGray5)
    private let descriptionLabel = UILabel()
    
    // MARK: Life cycle
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        constrain()
    }
    
    // MARK: Helpers
    private func configureUI() {
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        // moviePosterImage
        moviePosterImage.imageView.setPosterImage(posterPath: viewModel.moviePosterPath, networkManager: viewModel.networkManager)
        moviePosterImage.widthAnchor.constraint(equalToConstant: 130).isActive = true
        moviePosterImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        // titleLabel
        titleLabel.titleTextStyle(text: viewModel.movieTitle)
        // releaseDateLabel
        releaseDateLabel.text = "Released in \(viewModel.movieReleaseYear)"
        releaseDateLabel.font = .systemFont(ofSize: 20, weight: .medium)
        releaseDateLabel.textColor = .secondaryLabel
        // separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separator)
        // descriptionLabel
        descriptionLabel.text = viewModel.movieDescription
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.lineBreakStrategy = .hangulWordPriority
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        descriptionLabel.setLineSpacing(3)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
    }
    
    private func constrain() {
        let mainInfoStack = UIStackView(arrangedSubviews: [titleLabel, releaseDateLabel])
        mainInfoStack.axis = .vertical
        mainInfoStack.distribution = .equalSpacing
        mainInfoStack.isLayoutMarginsRelativeArrangement = true
        mainInfoStack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        mainInfoStack.translatesAutoresizingMaskIntoConstraints = false
        
        let posterWithMainInfoStack = UIStackView(arrangedSubviews: [moviePosterImage, mainInfoStack])
        posterWithMainInfoStack.axis = .horizontal
        posterWithMainInfoStack.alignment = .top
        posterWithMainInfoStack.spacing = 20
        posterWithMainInfoStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(posterWithMainInfoStack)
        
        NSLayoutConstraint.activate([
            mainInfoStack.heightAnchor.constraint(equalToConstant: 200),
            
            posterWithMainInfoStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            posterWithMainInfoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            posterWithMainInfoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            posterWithMainInfoStack.heightAnchor.constraint(equalToConstant: 200),
            
            separator.topAnchor.constraint(equalTo: posterWithMainInfoStack.bottomAnchor, constant: 25),
            separator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
