//
//  TabBarController.swift
//  MediaLog
//
//  Created by Joy Kim on 6/11/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    let navOne = UINavigationController(rootViewController: MediaTrendViewController())
    let navTwo = UINavigationController(rootViewController: MovieSearchViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
}

extension TabBarController {
    
    func setTabBar() {
        setViewControllers([navOne,navTwo], animated: true)
        setTabBarItem()
        
    }
    
    func setTabBarItem() {
        navOne.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        navTwo.tabBarItem = UITabBarItem(title: "영화", image: UIImage(systemName: "movieclapper"), selectedImage: UIImage(systemName: "movieClapper.fill"))
    }
 
}
