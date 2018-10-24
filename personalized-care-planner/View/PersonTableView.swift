//
//  PersonTableViewCell.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/10/19.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import UIKit
import Material
import FontAwesome_swift

class PersonTableView: TableView {
    var selectedIndex: Int?
    
    var dataSourceItems = [DataSourceItem]() {
        didSet {
            reloadData()
        }
    }
    
    open override func prepare() {
        super.prepare()
        dataSource = self
        delegate = self
        
        dataSourceItems.append(DataSourceItem())
        dataSourceItems.append(DataSourceItem())
        dataSourceItems.append(DataSourceItem())
        dataSourceItems.append(DataSourceItem())
        dataSourceItems.append(DataSourceItem())
        dataSourceItems.append(DataSourceItem())
        dataSourceItems.append(DataSourceItem())
        dataSourceItems.append(DataSourceItem())
        dataSourceItems.append(DataSourceItem())
    }
}

extension PersonTableView: TableViewDataSource, TableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceItems.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = "test"
        cell.textLabel?.fontSize = 20
        cell.imageView?.image = UIImage.fontAwesomeIcon(name: .userCircle, style: .solid, textColor: .lightGray, size: CGSize.init(width: 50, height: 50))
        cell.detailTextLabel?.text = "detail"
        cell.dividerColor = Color.grey.lighten2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var item = dataSourceItems[indexPath.row]
        self.selectedIndex = indexPath.row
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "RootVC"), object: nil)
    }
}
