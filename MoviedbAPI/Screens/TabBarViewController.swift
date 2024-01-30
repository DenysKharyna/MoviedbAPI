//
//  TabBarViewController.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 30.01.2024.
//

import UIKit

final class TabBarViewController: UITabBarController {

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
    }
    
    // MARK: Helpers
    private func configureTabs() {
        // Configuring First Tab
        let storyboard = UIStoryboard(name: "MoviesListViewController", bundle: nil)
        let moviesListVC = storyboard.instantiateViewController(withIdentifier: "moviesListVC")
        let moviesListTab = setupNavigationController(rootVC: moviesListVC,
                                                      tabBarImage: UIImage(systemName: "list.bullet.circle.fill")!,
                                                      title: "Movies List")
        
        // Configuring Second Tab
        let favoritesVC = FavoritesViewController()
        let favoritesTab = setupNavigationController(rootVC: favoritesVC,
                                                     tabBarImage: UIImage(systemName: "star.fill")!,
                                                     title: "Favorites")
        
        viewControllers = [moviesListTab, favoritesTab]
    }
    
    private func setupNavigationController(rootVC: UIViewController, tabBarImage: UIImage, title: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootVC)
        rootVC.title = title
        nav.navigationBar.prefersLargeTitles = true
        nav.tabBarItem = UITabBarItem(title: title, image: tabBarImage, selectedImage: nil)
        return nav
    }
}
