//
//  FavoritesViewController.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 30.01.2024.
//

import UIKit

final class FavoritesViewController: UIViewController {
    // MARK: Properties
    private let cellID = "favoriteMovieCellId"
    private let tableView = UITableView()
    
    private let viewModel = FavoritesViewModel(coreDataManager: CoreDataManager())
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureUI()
        constrain()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavoriteMovies()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: Helpers
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func constrain() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        215
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FavoritesTableViewCell
        cell.configure(with: FavoritesCellViewModel(movie: viewModel.favoriteMovies[indexPath.row]))
        return cell
    }
}
