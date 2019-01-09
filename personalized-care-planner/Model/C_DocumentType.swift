//
//  C_DocumentType.swift
//  personalized-care-planner
//
//  Created by omata on 2019/01/09.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import RealmSwift

class DocumentType: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var type = ""
    @objc dynamic var createDate = NSDate()
    @objc dynamic var updatedate = NSDate()
    @objc dynamic var isDelete = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(type: String) {
        self.init()
        self.type = type
    }
}
