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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "bye", style: .plain, target: self, action: #selector(bye))
        title = "Detail"
        view.backgroundColor = .white
        splitViewController?.delegate = self        
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
        title = "\(sender!)"
        return true
    }
    
    @objc func bye() {
        print("bye")
    }
}
