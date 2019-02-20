//
//  PersonModalViewController.swift
//  personalized-care-planner
//
//  Created by omata on 2019/02/20.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import UIKit
import Material

enum PersonModalViewMode {
    case add
    case edit
}

class PersonModalViewController: UIViewController {
    let section = ["姓", "名", "かな(姓)", "かな(名)", "グループ"]
    var items = [[""],[""],[""],[""],[""]]
    var leftNavigationItems: [UIBarButtonItem]!
    var rightNavigationItems: [UIBarButtonItem]!
    var mode: PersonModalViewMode!
    var updatePerson = Person()

    var tableView: UITableView!
    
    var updateLastName = ""
    var updateFirstName = ""
    var updateKanaLastName = ""
    var updateKanaFirstName = ""
    var updateGroup = "その他"
    
    init(mode: PersonModalViewMode) {
        self.mode = mode
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "person"
        
        prepareNavigationBar()
        prepareTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PersonModalViewController {
    internal func prepareNavigationBar() {
        /// LEFT Navigation
        leftNavigationItems = []
        let closeButton = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        leftNavigationItems.append(closeButton)
        navigationItem.leftBarButtonItems = leftNavigationItems
        
        /// RIGHT Navigation
        rightNavigationItems = []
        let saveButton = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(add))
        let updateButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(update))
        
        if self.mode == .add {
            rightNavigationItems.append(saveButton)
        } else {
            rightNavigationItems.append(updateButton)
        }
        navigationItem.rightBarButtonItems = rightNavigationItems
    }
    
    internal func prepareTableView() {
        tableView = UITableView.init(frame: self.navigationController!.view.frame, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(TextFieldViewCell.self, forCellReuseIdentifier: "TextFieldCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
}

extension PersonModalViewController {
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func add() {
        if let cell = tableView.visibleCells[tableView.visibleCells.count - 1] as? TextFieldViewCell {
            cell.textField.resignFirstResponder()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func update() {
        if let cell = tableView.visibleCells[tableView.visibleCells.count - 1] as? TextFieldViewCell {
            cell.textField.resignFirstResponder()
        }

        dismiss(animated: true, completion: nil)
    }
}


extension PersonModalViewController: UITableViewDelegate, UITableViewDataSource, TextFieldViewCellDelegate {
    func textFieldDidEndEditing(cell: TextFieldViewCell, value: String) {
        switch cell.tag {
        case 0:  /// lastname
            self.updateLastName = value
        case 1:  /// firstname
            self.updateFirstName = value
        case 2:  /// kanalastname
            self.updateKanaLastName = value
        case 3:  /// kanafirstname
            self.updateKanaFirstName = value
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section != 4 { /// 所属グループ　以外
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldViewCell
            cell.selectionStyle = .blue
            cell.tag = indexPath.section /// sectionIndex で update 箇所の識別
            cell.textField.text = items[indexPath.section][0]
            cell.textField.placeholder = "ここをタップして" + section[indexPath.section] + "を入力してください"
            cell.delegate = self

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.selectionStyle = .blue
            cell.tag = indexPath.section
//            if let group = self.group {
//                cell.textLabel?.text = group.name
//            } else {
//                cell.textLabel?.text = "その他"
//            }

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 4 {
//            let modalPersonalGroupEditTableVC = ModalPersonGroupEditTableViewController()
//            modalPersonalGroupEditTableVC.delegate = self
//            self.navigationController?.pushViewController(modalPersonalGroupEditTableVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
}
