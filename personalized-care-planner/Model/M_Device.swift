//
//  M_Device.swift
//  personalized-care-planner
//
//  Created by omata on 2019/01/09.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import RealmSwift

class Device: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var deviceIdentifier = ""
    @objc dynamic var createDate = NSDate()
    @objc dynamic var updatedate = NSDate()
    @objc dynamic var isDelete = false
    
    let device_groups = LinkingObjects(fromType: Device_Group.self, property: "device")
    let device_documents = LinkingObjects(fromType: Device_Document.self, property: "device")
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(name: String, deviceIdentifier: String) {
        self.init()
        self.name = name
        self.deviceIdentifier = deviceIdentifier
    }
    
    class func getDevice() -> Device? {
        let deviceName = UIDevice.current.name
        do {
            guard let realm = RealmManager.sharedInstance.localRealm else {
                return nil
            }
            
            let device = realm.objects(Device.self).filter("name == %@ AND isDelete == false", deviceName).first
            return device
        }
    }
}
