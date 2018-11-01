//
//  SplitDetailViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/10/17.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import UIKit
import Material

class SplitDetailViewController: UITabBarController {
    var rightNavigationItems: [UIBarButtonItem]!
    var leftNavigationItems: [UIBarButtonItem]!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "detail"
        view.backgroundColor = .white
        
        prepareNavigationBar()
        prepareTabView()
    }
}

extension SplitDetailViewController {
    internal func prepareNavigationBar() {
        /// LEFT Navigation
        leftNavigationItems = []
        navigationItem.leftBarButtonItems = leftNavigationItems
        
        /// RIGHT Navigation
        rightNavigationItems = []
        let moreButton = UIBarButtonItem.init(image: Icon.cm.moreHorizontal, style: .plain, target: self, action: nil)
        rightNavigationItems.append(moreButton)
        let printButton = UIBarButtonItem.init(image: Icon.cm.image, style: .plain, target: self, action: nil)
        rightNavigationItems.append(printButton)
        let addButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(tagViewController))
        rightNavigationItems.append(addButton)
        navigationItem.rightBarButtonItems = rightNavigationItems
    }
    
    internal func prepareTabView() {
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
        
        self.setViewControllers(tabViewControllers, animated: false)
    }
}

extension SplitDetailViewController {
    @objc func tagViewController() {  /// after: add arguments
        let tagVC = TagViewController()
        let navTagVC = NavigationController.init(rootViewController: tagVC)
        self.present(navTagVC, animated: true, completion: nil)
    }
}
