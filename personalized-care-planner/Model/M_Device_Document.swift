//
//  M_Device_Document.swift
//  personalized-care-planner
//
//  Created by a. omata on 2019/01/30.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import RealmSwift

class Device_Document: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var device: Device!
    @objc dynamic var document: Document!
    @objc dynamic var createDate = NSDate()
    @objc dynamic var updatedate = NSDate()
    @objc dynamic var isDelete = false
    
    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(device: Device, document: Document) {
        self.init()
        self.device = device
        self.document = document
    }
}
