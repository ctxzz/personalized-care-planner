//
//  M_Category.swift
//  personalized-care-planner
//
//  Created by omata on 2019/01/09.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var createDate = NSDate()
    @objc dynamic var updatedate = NSDate()
    @objc dynamic var isDelete = false
    
    let templates = LinkingObjects(fromType: Template.self, property: "category")
    let annotations = LinkingObjects(fromType: Annotation.self, property: "category")
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
