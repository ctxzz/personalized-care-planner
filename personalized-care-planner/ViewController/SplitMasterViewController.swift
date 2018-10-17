//
//  SplitMasterViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/10/17.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import UIKit

class SplitMasterViewController: UITableViewController, UISplitViewControllerDelegate {
    var collapseDetailViewController = true
    var names = ["person1", "person2","person3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        splitViewController?.delegate = self
        title = "master"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "hello", style: .plain, target: self, action: #selector(hello))
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = SplitDetailViewController()
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            self.showDetailViewController(detailVC, sender: names[indexPath.row])
        } else {
            self.show(detailVC, sender: names[indexPath.row])
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return collapseDetailViewController
    }
    
    @objc func hello() {
        print("hello")
    }
}