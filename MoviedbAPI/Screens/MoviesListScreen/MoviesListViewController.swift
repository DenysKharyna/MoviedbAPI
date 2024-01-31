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
        let vc = MovieDetailsViewController(viewModel: MovieDetailsViewModel(movie: movie))
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
extension MoviesListViewController: ReloadCollectionViewDelegate {
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
