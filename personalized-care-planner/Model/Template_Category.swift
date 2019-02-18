//
//  Template_Category.swift
//  personalized-care-planner
//
//  Created by omata on 2019/02/18.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import RealmSwift

class Template_Category: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var template: Template!
    @objc dynamic var category: Category!
    @objc dynamic var createDate = NSDate()
    @objc dynamic var updatedate = NSDate()
    @objc dynamic var isDelete = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(template: Template, category: Category) {
        self.init()
        self.template = template
        self.category = category
    }

}
