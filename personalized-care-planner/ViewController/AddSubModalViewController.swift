//
//  AddSubModalViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/11/14.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import UIKit
import Material

protocol ModalSelectDelegate {
    func onSelected(category: String) -> ()
    func onSelected(color: String) -> ()
}

enum ListType: String {
    case color = "Color"
    case category = "Category"
}

class AddSubModalViewController: UIViewController {
    var delegate: ModalSelectDelegate?
    var colorList = ["Red", "Blue", "Gray"]
    var categoryList = ["personality", "relation", "story", "goal"]
    var section: [String]!
    var items: [[String]]!
    var tableView: UITableView!
    var listType: ListType?
    var currentColorSelectedItemIndexPath: IndexPath?
    var currentCategorySelectedItemIndexPath: IndexPath?
    var isInitialize = false
    
    func initializate(listType: ListType) {
        self.section = [String]()
        self.items = [[String]]()
        
        self.listType = listType
        switch listType {
        case .category:
            self.section.append(ListType.category.rawValue)
            self.items.append(categoryList)
        case .color:
            self.section.append(ListType.color.rawValue)
            self.items.append(colorList)
        }
        
        /// 初期化ずみだったらtableViewをreloadして更新する
        /// 選択項目にchekmarkをつける処理
        if !isInitialize {
            isInitialize = true
        } else if isInitialize {
            tableView.reloadData()
            
            switch listType {
            case .category:
                if let indexPath = currentCategorySelectedItemIndexPath {
                    let cell = self.tableView.cellForRow(at: indexPath)
                    cell?.accessoryType = .checkmark
                }
            case .color:
                if let indexPath = currentColorSelectedItemIndexPath {
                    let cell = self.tableView.cellForRow(at: indexPath)
                    cell?.accessoryType = .checkmark
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        items.append(categoryList)
        items.append(colorList)
        prepareTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AddSubModalViewController {
    internal func prepareTableView() {
        tableView = UITableView.init(frame: self.navigationController!.view.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TagList")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = false
        self.view.addSubview(tableView)
    }
}

extension AddSubModalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "TagList")
        cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
        cell.selectionStyle = .blue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        let selectedItem = items[indexPath.section][indexPath.row]
        if self.listType == .category {
            self.currentCategorySelectedItemIndexPath = indexPath
            self.delegate?.onSelected(category: selectedItem)
        } else if self.listType == .color {
            self.currentColorSelectedItemIndexPath = indexPath
            self.delegate?.onSelected(color: selectedItem)
        } else {
            // error
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
    
}
