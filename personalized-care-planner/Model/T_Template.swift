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
    @objc dynamic var filename = ""
    @objc dynamic var createDate = NSDate()
    @objc dynamic var updatedate = NSDate()
    @objc dynamic var isDelete = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(filename: String) {
        self.init()
        self.filename = filename
    }
    
    class func getTemplate(id: String) -> Template? {
        do {
            guard let realm = RealmManager.sharedInstance.localRealm else { return nil }
            let template = realm.objects(Template.self).filter("id == %@", id).first
            return template
        }
    }
}
