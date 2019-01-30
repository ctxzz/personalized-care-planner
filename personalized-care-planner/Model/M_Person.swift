//
//  M_Person.swift
//  personalized-care-planner
//
//  Created by omata on 2019/01/09.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var lastName = ""
    @objc dynamic var firstName = ""
    @objc dynamic var fullName = ""
    @objc dynamic var kanaLastName = ""
    @objc dynamic var kanaFirstName = ""
    @objc dynamic var personType: PersonType!
    @objc dynamic var createDate = NSDate()
    @objc dynamic var updatedate = NSDate()
    @objc dynamic var isDelete = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(last: String, first: String, personType: PersonType) {
        self.init()
        self.lastName = last
        self.firstName = first
        self.fullName = last + " " +  first
        self.personType = personType
    }
}
