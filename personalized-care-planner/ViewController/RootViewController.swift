//
//  RootViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/10/01.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import UIKit

class RootViewController: UISplitViewController, UISplitViewControllerDelegate {
    let masterNav = UINavigationController()
    let detailNav = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// master
        let masterVC = SplitMasterViewController()
        masterNav.addChild(masterVC)
        
        /// detail
        let detailVC = SplitDetailViewController()
        detailNav.addChild(detailVC)
        
        viewControllers = [masterNav, detailNav]

//        var tabViewControllers: [UIViewController] = []
//        /// TabBar PDF
//        let tabBarPDFVC = TabBarPDFViewController()
//        tabBarPDFVC.tabBarItem = UITabBarItem.init(title: "PDF", image: nil, tag: 1)
//        tabViewControllers.append(tabBarPDFVC)
//        /// TabBar Graoh
//        let tabBarGraphVC = TabBarGraphViewController()
//        tabBarGraphVC.tabBarItem = UITabBarItem.init(title: "Graph", image: nil, tag: 2)
//        tabViewControllers.append(tabBarGraphVC)
//        /// TabBar Statics
//        let tabBarStaticsVC = TabBarStaticsViewController()
//        tabBarStaticsVC.tabBarItem = UITabBarItem.init(title: "Statics", image: nil, tag: 3)
//        tabViewControllers.append(tabBarStaticsVC)
//        
//        detailVC.setViewControllers(tabViewControllers, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

