//
//  AddModalViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/11/12.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import UIKit
import Material

struct Tag {
//    let user: User
    let color: UIColor
    let category: String
    let description: String
}

class AddModalViewController: UIViewController {
    var leftNavigationItems: [UIBarButtonItem]!
    var rightNavigationItems: [UIBarButtonItem]!
    let section = ["Tag Detail"]
    let items = [["Category", "Color", "Description"]]
    var tableView: UITableView!
    var tag: Tag!
    
    var addSubMVC: AddSubModalViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Annotation"
        view.backgroundColor = .white
        
        addSubMVC = AddSubModalViewController()
        prepareNavigationBar()
        prepareTableView()
    }
}

extension AddModalViewController {
    internal func prepareNavigationBar() {
        /// LEFT Navigation
        leftNavigationItems = []
        let closeButton = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(closeModalView))
        leftNavigationItems.append(closeButton)
        navigationItem.leftBarButtonItems = leftNavigationItems
        
        /// RIGHT Navigation
        rightNavigationItems = []
        let saveButton = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(saveTag))
        rightNavigationItems.append(saveButton)
        navigationItem.rightBarButtonItems = rightNavigationItems
    }
    
    internal func prepareTableView() {
        tableView = UITableView.init(frame: self.navigationController!.view.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
}

extension AddModalViewController {
    @objc func closeModalView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTag() {
        //
    }
}

extension AddModalViewController: ModalSelectDelegate {
    func onSelected(category: String) {
        let selectedCell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0))
        selectedCell?.detailTextLabel?.text = category
        selectedCell?.isSelected = false
        
    }
    
    func onSelected(color: String) {
        let selectedCell = self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0))
        selectedCell?.detailTextLabel?.text = color
        selectedCell?.isSelected = false
    }
}

extension AddModalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
        cell.detailTextLabel?.text = ""
        cell.selectionStyle = .blue
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.section][indexPath.row]
        
        switch selectedItem {
        case items[0][0]:
            addSubMVC.initializate(listType: .category)
            addSubMVC.delegate = self
            self.navigationController?.pushViewController(addSubMVC, animated: true)
        case items[0][1]:
            addSubMVC.initializate(listType: .color)
            addSubMVC.delegate = self
            self.navigationController?.pushViewController(addSubMVC, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
}
