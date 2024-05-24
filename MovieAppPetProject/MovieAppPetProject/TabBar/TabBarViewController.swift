//
//  TabBarViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/05/24.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let rootView = self.viewControllers?[self.selectedIndex] as? UINavigationController
        rootView?.popToRootViewController(animated: false)
    }
}
