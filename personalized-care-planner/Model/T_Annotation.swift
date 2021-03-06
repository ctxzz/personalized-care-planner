//
//  M_Annotation.swift
//  personalized-care-planner
//
//  Created by omata on 2019/01/09.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import RealmSwift

class Annotation: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var text = ""
    @objc dynamic var type = ""
    @objc dynamic var colorCode = ""
    @objc dynamic var category: Category!
    @objc dynamic var document: Document!
    @objc dynamic var annotator: Person!
    @objc dynamic var targetPerson: Person!
    @objc dynamic var createDate = NSDate()
    @objc dynamic var updatedate = NSDate()
    @objc dynamic var isDelete = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(text: String, type: String, colorCode: String, category: Category, document: Document, annotator: Person, targetPerson: Person) {
        self.init()
        self.text = text
        self.type = type
        self.colorCode = colorCode
        self.category = category
        self.document = document
        self.annotator = annotator
        self.targetPerson = targetPerson
    }
    
    class func getAnnotation(id: String) -> Annotation? {
        do {
            guard let realm = RealmManager.sharedInstance.localRealm else { return nil }
            let annotation = realm.objects(Annotation.self).filter("id == %@", id).first
            return annotation
        }
    }
    
    class func getAnnotations(document: Document) -> Results<Annotation>? {
        do {
            guard let realm = RealmManager.sharedInstance.localRealm else { return nil }
            let annotations = realm.objects(Annotation.self).filter("document == %@", document)
            return annotations
        }
    }
    
    class func getAnnotator(id: String) -> Person? {
        do {
            let annotation = getAnnotation(id: id)
            return annotation?.annotator
        }
    }
    
    class func getTargetPerson(id: String) -> Person? {
        do {
            let annotation = getAnnotation(id: id)
            return annotation?.targetPerson
        }
    }
    
    class func getDocument(id: String) -> Document? {
        do {
            let annotation = getAnnotation(id: id)
            return annotation?.document

        }
    }
    
    class func getCategory(id: String) -> Category? {
        do {
            let annotation = getAnnotation(id: id)
            return annotation?.category
        }
    }
}
