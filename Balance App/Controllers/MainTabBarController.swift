//
//  MainTabBarController.swift
//  Balance App
//
//  Created by Олейник Богдан on 18.05.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileViewController = ProfileViewController()
        let adviseViewConroller = AdviseViewController()
        let tasksViewController = TasksViewController()
        
        tabBar.tintColor = .mainColor()
        tabBar.backgroundColor = .backgroundColor()
        let boldConfiguration = UIImage.SymbolConfiguration(weight: .medium)
        let profileImage = UIImage(systemName: "person", withConfiguration: boldConfiguration)!
        let adviseImage = UIImage(systemName: "books.vertical", withConfiguration: boldConfiguration)!
        let tasksImage = UIImage(systemName: "checkmark.circle", withConfiguration: boldConfiguration)!
        
        viewControllers = [
            generateNavigationController(rootViewController: adviseViewConroller, title: "Advise", image: adviseImage),
            generateNavigationController(rootViewController: profileViewController, title: "Profile", image: profileImage),
            generateNavigationController(rootViewController: tasksViewController, title: "Tasks", image: tasksImage)
            
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigaionVC = UINavigationController(rootViewController: rootViewController)
        navigaionVC.tabBarItem.title = title
        navigaionVC.tabBarItem.image = image
        return navigaionVC
    }
    
}
