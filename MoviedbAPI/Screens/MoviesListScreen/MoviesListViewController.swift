//
//  ViewController.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 30.01.2024.
//

import UIKit

final class MoviesListViewController: UIViewController {
    
    // MARK: IBOutlets & Properties
    @IBOutlet weak var collectionView: UICollectionView!
    private let cellID = "movieCellID"
    
    private let viewModel = MoviesListViewModel(networkManager: NetworkManager())
    
    // MARK: Life cycle    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getTopRatedMovies()
        configureCollectionView()
    }
    
    // MARK: Helpers
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MoviesListCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(_:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
    }
    
    // MARK: Selectors
    @objc private func longPressGestureRecognized(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: touchPoint), 
                let cell = collectionView.cellForItem(at: indexPath) as? MoviesListCollectionViewCell {
                guard let posterImage = cell.movieImage.image else { return }
                let actionAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                actionAlert.addAction(UIAlertAction(title: "Add to Favorites", style: .default, handler: { [weak self] _ in
                    guard let self = self else { return }
                    self.viewModel.addMovieToFavorites(movie: self.viewModel.moviesList[indexPath.row], moviePoster: posterImage)
                }))
                actionAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                present(actionAlert, animated: true)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MoviesListCollectionViewCell
        cell.configure(with: MoviesListCellViewModel(movie: viewModel.moviesList[indexPath.row]))
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MoviesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.moviesList[indexPath.row]
        let movieDetailViewModel = MovieDetailsViewModel(movie: movie, networkManager: viewModel.networkManager)
        let vc = MovieDetailsViewController(viewModel: movieDetailViewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Collection View Layout Configuration
extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.cellSize(collectionViewWidth: collectionView.bounds.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 15, left: 20, bottom: 20, right: 20)
    }
}

// MARK: - ReloadCollectionViewDelegate
extension MoviesListViewController: MovieListDelegate {
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func presentError(message: String) {
        presentErrorAlert(message: message)
    }

}
