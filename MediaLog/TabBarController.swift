//
//  TabBarController.swift
//  MediaLog
//
//  Created by Joy Kim on 6/11/24.
//

import UIKit

class TabBarController: UITabBarController {
    let myLogMainVC = UINavigationController(rootViewController: MediaTrendViewController())
    let movieSearchVC = UINavigationController(rootViewController: MovieSearchViewController())
    let movieHomeMainVC = UINavigationController(rootViewController: MovieHomeViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
}

extension TabBarController {
    
    func setTabBar() {
        tabBar.tintColor = UIColor.accent
        setViewControllers([movieHomeMainVC,myLogMainVC, movieSearchVC], animated: true)
        setTabBarItem()
        
    }
    
    func setTabBarItem() {
        movieHomeMainVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        movieSearchVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))

        myLogMainVC.tabBarItem = UITabBarItem(title: "저장소", image: UIImage(systemName: "movieclapper"), selectedImage: UIImage(systemName: "movieclapper.fill"))
    }
}


