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
        let masterVC = SplitMasterViewController()
        masterNav.addChildViewController(masterVC)
        let detailVC = SplitDetailViewController()
        detailNav.addChildViewController(detailVC)
        viewControllers = [masterNav, detailNav]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

