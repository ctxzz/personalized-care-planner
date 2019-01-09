//
//  M_Template.swift
//  personalized-care-planner
//
//  Created by omata on 2019/01/09.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import RealmSwift

class Template: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var document: Document!
    @objc dynamic var category: Category!
    @objc dynamic var x = 0
    @objc dynamic var y = 0
    @objc dynamic var width = 0
    @objc dynamic var height = 0
    @objc dynamic var priority = 0
    @objc dynamic var createDate = NSDate()
    @objc dynamic var updatedate = NSDate()
    @objc dynamic var isDelete = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(document: Document, category: Category) {
        self.init()
        self.document = document
        self.category = category
    }
}
