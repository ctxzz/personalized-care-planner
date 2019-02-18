//
//  M_Device_Group.swift
//  personalized-care-planner
//
//  Created by omata on 2019/01/09.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import RealmSwift

class Device_Group: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var device: Device!
    @objc dynamic var group: Group!
    @objc dynamic var createDate = NSDate()
    @objc dynamic var updatedate = NSDate()
    @objc dynamic var isDelete = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(device: Device, group: Group) {
        self.init()
        self.device = device
        self.group = group
    }
}
