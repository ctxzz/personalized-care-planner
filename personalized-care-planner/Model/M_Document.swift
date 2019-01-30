//
//  M_Document.swift
//  personalized-care-planner
//
//  Created by omata on 2019/01/09.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import RealmSwift

class Document: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var filename = ""
    @objc dynamic var documentType: DocumentType!
    @objc dynamic var person: Person!
    @objc dynamic var localPath = ""
    @objc dynamic var remoteURL = ""
    @objc dynamic var createDate = NSDate()
    @objc dynamic var updatedate = NSDate()
    @objc dynamic var isDelete = false
    
    let device_documents = LinkingObjects(fromType: Device_Document.self, property: "document")
    let annotations = LinkingObjects(fromType: Annotation.self, property: "document")
    let templates = LinkingObjects(fromType: Template.self, property: "document")
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(filename: String, documentType: DocumentType, person: Person, localPath: String, remoteURL: String) {
        self.init()
        self.filename = filename
        self.documentType = documentType
        self.person = person
        self.localPath = localPath
        self.remoteURL = remoteURL
    }
}
