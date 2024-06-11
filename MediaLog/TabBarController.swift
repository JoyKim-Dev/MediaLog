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
        // 일단 작업중인 탭을 index0에 넣어둠. 나중에 순서 변경 필요
        setViewControllers([navTwo,navOne], animated: true)
        setTabBarItem()
        
    }
    
    func setTabBarItem() {
        navOne.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        navTwo.tabBarItem = UITabBarItem(title: "영화", image: UIImage(systemName: "movieclapper"), selectedImage: UIImage(systemName: "movieClapper.fill"))
    }
 
}
