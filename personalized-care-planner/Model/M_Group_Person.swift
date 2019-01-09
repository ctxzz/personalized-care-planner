//
//  M_Group_Person.swift
//  personalized-care-planner
//
//  Created by omata on 2019/01/09.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import RealmSwift

class Group_Person: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var group: Group!
    @objc dynamic var person: Person!
    @objc dynamic var createDate = NSDate()
    @objc dynamic var updatedate = NSDate()
    @objc dynamic var isDelete = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(group: Group, person: Person) {
        self.init()
        self.group = group
        self.person = person
    }
}
