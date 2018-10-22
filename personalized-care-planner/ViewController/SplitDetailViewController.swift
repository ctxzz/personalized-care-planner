//
//  SplitDetailViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/10/17.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import UIKit

class SplitDetailViewController: UITabBarController, UISplitViewControllerDelegate {
    var rightNavigationItems: [UIBarButtonItem]!
    var leftNavigationItems: [UIBarButtonItem]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        view.backgroundColor = .white
        splitViewController?.delegate = self
        
        /// LEFT Navigation
        leftNavigationItems = []
        navigationItem.leftBarButtonItems = leftNavigationItems
        
        /// RIGHT Navigation
        rightNavigationItems = []
        let actionButton = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: nil)
        rightNavigationItems.append(actionButton)
        let addButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: nil)
        rightNavigationItems.append(addButton)
        navigationItem.rightBarButtonItems = rightNavigationItems
        
        /// bottom Tab Item
        var tabViewControllers: [UIViewController] = []
        /// TabBar PDF
        let tabBarPDFVC = TabBarPDFViewController()
        tabBarPDFVC.tabBarItem = UITabBarItem.init(title: "PDF", image: nil, tag: 1)
        tabViewControllers.append(tabBarPDFVC)
        /// TabBar Graoh
        let tabBarGraphVC = TabBarGraphViewController()
        tabBarGraphVC.tabBarItem = UITabBarItem.init(title: "Graph", image: nil, tag: 2)
        tabViewControllers.append(tabBarGraphVC)
        /// TabBar Statics
        let tabBarStaticsVC = TabBarStaticsViewController()
        tabBarStaticsVC.tabBarItem = UITabBarItem.init(title: "Statics", image: nil, tag: 3)
        tabViewControllers.append(tabBarStaticsVC)
        
        self.setViewControllers(tabViewControllers, animated: true)
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
        title = "\(sender!)"
        return true
    }
    
    @objc func bye() {
        print("bye")
    }
}
