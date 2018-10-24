//
//  SplitMasterViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/10/17.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import UIKit
import Material

class SplitMasterViewController: UIViewController {
    var rightNavigationItems: [UIBarButtonItem]!
    var leftNavigationItems: [UIBarButtonItem]!
    
    internal var tableView: PersonTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "master"
        prepareNavigationBar()
        prepareTableView()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.reloadData()
    }
    
}

extension SplitMasterViewController {
    internal func prepareNavigationBar() {
        /// LEFT Navigation
        leftNavigationItems = []
        let settingButton = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: nil)
        leftNavigationItems.append(settingButton)
        navigationItem.leftBarButtonItems = leftNavigationItems
        
        /// RIGHT Navigation
        rightNavigationItems = []
        let searchButton = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: nil)
        rightNavigationItems.append(searchButton)
        navigationItem.rightBarButtonItems = rightNavigationItems
    }
    
    internal func prepareTableView() {
        tableView = PersonTableView()
        view.layout(tableView).edges()
    }
    
    internal func reloadData() {
        let dataSourceItems = [DataSourceItem]()
        tableView.dataSourceItems = dataSourceItems
    }
}
