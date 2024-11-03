//
//  ViewController.swift
//  JustChat
//
//  Created by Ангел предохранитель on 02.11.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .systemBackground
        setupNavigationControllers()
    }

    //MARK: - private methods
    
    private func setupNavigationControllers() {
        let vc1 = ConversationsViewController()
        let vc2 = ProfileViewController()
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        
        nav1.tabBarItem = UITabBarItem(title: "Conversations", image: UIImage(systemName: "message.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 2)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2], animated: true)
    }
}

