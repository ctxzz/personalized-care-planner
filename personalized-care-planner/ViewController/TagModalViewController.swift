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
    var color: UIColor
    var category: String
    var description: String
    var size: CGSize
    var position: CGPoint
    var isTappedPosition: Bool
    
    init() {
        self.color = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.category = ""
        self.description = ""
        self.size = CGSize.init(width: 0, height: 0)
        self.position = CGPoint.init(x: 0, y: 0)
        self.isTappedPosition = false
    }
    
    func getSize() -> CGSize {
        let charSize = 48
        let maxRow = 10
        let minRow = description.count
        let colum = description.count / maxRow + 1

        if colum <= 1 {
            let width = minRow * charSize
            let height = charSize
            return CGSize.init(width: width, height: height)
        } else {
            let width = maxRow * charSize
            let height = colum * charSize
            return CGSize.init(width: width, height: height)
        }
    }
    
    func getPoint() -> CGPoint {
        if isTappedPosition { return position }
        switch category {
        case "personality":
            let x = Int.random(in: 1 ... 1599)
            let y = Int.random(in: 1100 ... 2200)
            return CGPoint.init(x: x, y: y)
        case "relation":
            let x = Int.random(in: 1600 ... 3300)
            let y = Int.random(in: 1100 ... 2200)
            return CGPoint.init(x: x, y: y)
        case "story":
            let x = Int.random(in: 1 ... 1599)
            let y = Int.random(in: 1 ... 1099)
            return CGPoint.init(x: x, y: y)
        case "goal":
            let x = Int.random(in: 1600 ... 3300)
            let y = Int.random(in: 1 ... 1099)
            return CGPoint.init(x: x, y: y)
        default:
            return CGPoint.init(x: 10, y: 10)
        }
    }
    
    func getCategory() -> String {
        if !isTappedPosition { return category }
        let x = position.x
        let y = position.y
        
        if x < 1600 && 1100 <= y {
            return "personality"
        } else if 1600 <= x && 1100 <= y {
            return "relation"
        } else if x < 1600 && y < 1100 {
            return "story"
        } else if 1600 <= x && y < 1100 {
            return "goal"
        } else {
            return ""
        }
    }
    
    func getColor(color: UIColor) -> String {
        switch color {
        case UIColor(red: 255, green: 0, blue: 0, alpha: 0.5):
            return "Red"
        case UIColor(red: 0, green: 0, blue: 255, alpha: 0.3):
            return "Blue"
        case UIColor(red: 0, green: 0, blue: 0, alpha: 0.3):
            return "Gray"
        default:
            return "Gray"
        }
    }
}

enum TagModalViewMode {
    case add
    case edit
}

class TagModalViewController: UIViewController {
    var delegate: TagDelegate? = nil
    var leftNavigationItems: [UIBarButtonItem]!
    var rightNavigationItems: [UIBarButtonItem]!
    let section = ["Tag Type", "Description"]
    let items = [["Category", "Color"], [""]]
    var tableView: UITableView!
    var tag = Tag()
    var mode: TagModalViewMode!

    var tagSubMVC: TagSubModalViewController!
    
    init(mode: TagModalViewMode) {
        self.mode = mode
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add"
        
        if mode == .edit {
            title = "Edit"
        }
        
        view.backgroundColor = .white
        
        tagSubMVC = TagSubModalViewController()
        prepareNavigationBar()
        prepareTableView()
    }
}

extension TagModalViewController {
    internal func prepareNavigationBar() {
        /// LEFT Navigation
        leftNavigationItems = []
        let closeButton = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(closeModalView))
        leftNavigationItems.append(closeButton)
        navigationItem.leftBarButtonItems = leftNavigationItems
        
        /// RIGHT Navigation
        rightNavigationItems = []
        let saveButton = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(saveTag))
        let updateButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(updateTag))
        
        if self.mode == .add {
            rightNavigationItems.append(saveButton)
        } else {
            rightNavigationItems.append(updateButton)
        }
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

extension TagModalViewController {
    @objc func closeModalView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTag() {
        if let cell = tableView.visibleCells[tableView.visibleCells.count - 1] as? TextFieldViewCell {
            cell.textField.resignFirstResponder()
        }
        
        self.delegate?.addTag(tag: tag)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func updateTag() {
        if let cell = tableView.visibleCells[tableView.visibleCells.count - 1] as? TextFieldViewCell {
            cell.textField.resignFirstResponder()
        }
        
        self.delegate?.editTag(tag: tag)
        dismiss(animated: true, completion: nil)
    }
    
    func stringToColor(colorName: String) -> UIColor {
        switch colorName {
        case "Red":
            return UIColor.init(red: 255, green: 0, blue: 0, alpha: 0.5)
        case "Blue":
            return UIColor.init(red: 0, green: 0, blue: 255, alpha: 0.3)
        case "Gray":
            return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        default:
            return .gray
        }
    }
}

extension TagModalViewController: ModalSelectDelegate {
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

extension TagModalViewController: UITableViewDelegate, UITableViewDataSource, TextFieldViewCellDelegate {
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
            if items[indexPath.section][indexPath.row] == "Category" {
                cell.detailTextLabel?.text = tag.getCategory()
            } else if items[indexPath.section][indexPath.row] == "Color" {
                cell.detailTextLabel?.text = tag.getColor(color: tag.color)
            }
            cell.selectionStyle = .blue
            cell.accessoryType = .disclosureIndicator
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldViewCell
            cell.selectionStyle = .blue
            cell.textField.text = tag.description
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
            if tag.isTappedPosition { break } /// tap位置が指定されている場合はは変更できない
            tagSubMVC.initializate(listType: .category)
            tagSubMVC.delegate = self
            self.navigationController?.pushViewController(tagSubMVC, animated: true)
        case items[0][1]:
            tagSubMVC.initializate(listType: .color)
            tagSubMVC.delegate = self
            self.navigationController?.pushViewController(tagSubMVC, animated: true)
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
