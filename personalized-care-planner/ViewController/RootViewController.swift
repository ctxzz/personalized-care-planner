//
//  RootViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/10/01.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import UIKit
import Material

class RootViewController: UISplitViewController {
    var fabMenuC: PersonTableFABMenuViewController!
    var masterVC: SplitMasterViewController!
    var masterNC: UINavigationController!
    var detailVC: SplitDetailViewController!
    var detailNC: UINavigationController!
    
    func initializer() {
        masterVC = SplitMasterViewController()
        fabMenuC = PersonTableFABMenuViewController.init(rootViewController: masterVC)
        masterNC = UINavigationController.init(rootViewController: fabMenuC)
        
        detailVC = SplitDetailViewController()
        detailNC = UINavigationController.init(rootViewController: detailVC)
        viewControllers = [masterNC, detailNC]
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
