//
//  TabBarController.swift
//  MediaLog
//
//  Created by Joy Kim on 6/11/24.
//

import UIKit

class TabBarController: UITabBarController {
    let trendHomeVC = UINavigationController(rootViewController: MediaTrendViewController())
    let movieSearchVC = UINavigationController(rootViewController: MovieSearchViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
}

extension TabBarController {
    
    func setTabBar() {
        tabBar.tintColor = UIColor.accent
        setViewControllers([trendHomeVC, movieSearchVC], animated: true)
        setTabBarItem()
        
    }
    
    func setTabBarItem() {
        trendHomeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
       movieSearchVC.tabBarItem = UITabBarItem(title: "영화", image: UIImage(systemName: "movieclapper"), selectedImage: UIImage(systemName: "movieClapper.fill"))
    }
 
}


