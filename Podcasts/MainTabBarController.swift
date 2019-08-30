//
//  MainTabBarController.swift
//  Podcasts
//
//  Created by pratik gupta on 30/08/19.
//  Copyright © 2019 pratik gupta. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        tabBar.tintColor = .purple
        setUpViewControllers()
    }
    
    //MARK:- SetUp functions
    func setUpViewControllers() {
        viewControllers = [
            generateNavigationController(for: ViewController(), title: "Favroites", image: #imageLiteral(resourceName: "favorites")),
            generateNavigationController(for: ViewController(), title: "Search", image: #imageLiteral(resourceName: "search")),
            generateNavigationController(for: ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        ]
    }
    
    //MARK:- Helper functions
    fileprivate func generateNavigationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
       // navController.navigationBar.prefersLargeTitles = true
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
