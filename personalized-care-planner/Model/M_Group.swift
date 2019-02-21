//
//  M_Group.swift
//  personalized-care-planner
//
//  Created by omata on 2019/01/09.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import RealmSwift

class Group: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var organization: Organization!
    @objc dynamic var createDate = NSDate()
    @objc dynamic var updatedate = NSDate()
    @objc dynamic var isDelete = false
    
    let group_persons = LinkingObjects(fromType: Group_Person.self, property: "group")
    let device_groups = LinkingObjects(fromType: Device_Group.self, property: "group")
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(name: String, organization: Organization) {
        self.init()
        self.name = name
        self.organization = organization
    }
    
    class func getAllGroups() -> Results<Group>? {
        do {
            guard let realm = RealmManager.sharedInstance.localRealm else { return nil }
            return realm.objects(Group.self)
        }
    }
}
