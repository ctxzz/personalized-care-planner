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
    var color: UIColor = .gray
    var category: String = ""
    var description: String = ""
}

class AddModalViewController: UIViewController {
    var leftNavigationItems: [UIBarButtonItem]!
    var rightNavigationItems: [UIBarButtonItem]!
    let section = ["Tag Type", "Description"]
    let items = [["Category", "Color"], [""]]
    var tableView: UITableView!
    var tag = Tag()
    
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
        tableView.register(TextFieldViewCell.self, forCellReuseIdentifier: "TextFieldCell")
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
    
    func stringToColor(colorName: String) -> UIColor {
        switch colorName {
        case "Red":
            return .red
        case "Blue":
            return .blue
        case "Gray":
            return .gray
        default:
            return .gray
        }
    }
}

extension AddModalViewController: ModalSelectDelegate {
    func onSelected(category: String) {
        let selectedCell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0))
        selectedCell?.detailTextLabel?.text = category
        selectedCell?.isSelected = false
        self.tag.category = category
    }
    
    func onSelected(color: String) {
        let selectedCell = self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0))
        selectedCell?.detailTextLabel?.text = color
        selectedCell?.isSelected = false
        self.tag.color = stringToColor(colorName: color)
    }
}

extension AddModalViewController: UITableViewDelegate, UITableViewDataSource, TextFieldViewCellDelegate {
    func textFieldDidEndEditing(cell: TextFieldViewCell, value: String) {
        self.tag.description = value
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
            cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
            cell.detailTextLabel?.text = ""
            cell.selectionStyle = .blue
            cell.accessoryType = .disclosureIndicator
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldViewCell
            cell.selectionStyle = .blue
            cell.textField.text = items[indexPath.section][0]
            cell.textField.placeholder = "ここをタップして" + section[indexPath.section] + "を入力してください"
            cell.delegate = self
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.section][indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)

        switch selectedItem {
        case items[0][0]:
            addSubMVC.initializate(listType: .category)
            addSubMVC.delegate = self
            self.navigationController?.pushViewController(addSubMVC, animated: true)
        case items[0][1]:
            addSubMVC.initializate(listType: .color)
            addSubMVC.delegate = self
            self.navigationController?.pushViewController(addSubMVC, animated: true)
        case items[1][0]: break
            /// do nothing
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
