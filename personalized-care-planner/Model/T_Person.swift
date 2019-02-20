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
    @objc dynamic var sex = 0
    @objc dynamic var personType: PersonType!
    @objc dynamic var createDate = NSDate()
    @objc dynamic var updatedate = NSDate()
    @objc dynamic var isDelete = false
    
    let group_persons = LinkingObjects(fromType: Group_Person.self, property: "person")
    let from_annotations = LinkingObjects(fromType: Annotation.self, property: "annotator")
    let to_annotations = LinkingObjects(fromType: Annotation.self, property: "targetPerson")
    let documents = LinkingObjects(fromType: Document.self, property: "person")
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(last: String, first: String, sex: Int, personType: PersonType) {
        self.init()
        self.lastName = last
        self.firstName = first
        self.fullName = last + " " +  first
        self.sex = sex
        self.personType = personType
    }
    
    class func getPerson(id: String) -> Person? {
        do {
            guard let realm = RealmManager.sharedInstance.localRealm else { return nil }
            let person = realm.objects(Person.self).filter("id == %@", id).first
            return person
        }
    }
}
