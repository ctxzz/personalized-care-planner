//
//  GroupTableViewController.swift
//  personalized-care-planner
//
//  Created by omata on 2019/02/21.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import UIKit

protocol GroupSelectDelegate {
    func onSelected(group: String) -> Void
}

class GroupTableViewController: UIViewController {
    var delegate: GroupSelectDelegate?
    var items = [String]()
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        guard let groups = Group.getAllGroups() else {
            return
        }
        for group in groups {
            items.append(group.name)
        }
        
        prepareTableView()
    }
    
    fileprivate func prepareTableView() {
        tableView = UITableView()
        tableView.frame = (self.navigationController?.view.frame)!
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension GroupTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.onSelected(group: items[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = self.items[indexPath.row]
        cell.selectionStyle = .blue
        
        return cell
    }
}
