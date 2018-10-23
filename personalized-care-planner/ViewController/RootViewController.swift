//
//  RootViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/10/01.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import UIKit

class RootViewController: UISplitViewController {
    var masterVC: SplitMasterViewController!
    var masterNavC: UINavigationController!
    var detailVC: SplitDetailViewController!
    var detailNavC: UINavigationController!
    
    func initializer() {
        masterVC = SplitMasterViewController()
        masterNavC = UINavigationController.init(rootViewController: masterVC)
        detailVC = SplitDetailViewController()
        detailNavC = UINavigationController.init(rootViewController: detailVC)
        viewControllers = [masterNavC, detailNavC]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateDetailView), name: Notification.Name.init("RootVC"), object: nil)

    }

    @objc func updateDetailView() {
//        guard let item = {}
        let detailVC = SplitDetailViewController()
        let detailNavC = UINavigationController.init(rootViewController: detailVC)
        
        splitViewController?.showDetailViewController(detailNavC, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RootViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
        print("detail")
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, show vc: UIViewController, sender: Any?) -> Bool {
        print("master")
        return true
    }
}
