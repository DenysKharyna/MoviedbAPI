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
        view.backgroundColor = .systemBackground
        print(viewModel.movie.title)
        print(viewModel.movie.overview)
        print(viewModel.getMovieReleaseYear)
    }
}
