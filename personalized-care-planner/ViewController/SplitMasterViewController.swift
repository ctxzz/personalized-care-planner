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
import Motion

class SplitMasterViewController: UIViewController {
    internal var tableView: PersonTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "master"
        prepareTableView()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.reloadData()
    }
}

extension SplitMasterViewController {
    internal func prepareTableView() {
        tableView = PersonTableView()
        view.layout(tableView).edges()
    }
    
    internal func reloadData() {
        let dataSourceItems = [DataSourceItem]()
        tableView.dataSourceItems = dataSourceItems
    }
}
