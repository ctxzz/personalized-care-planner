//
//  RealmManager.swift
//  personalized-care-planner
//
//  Created by omata on 2019/01/10.
//  Copyright © 2019 Kirilab. All rights reserved.
//

import Foundation
import RealmSwift

enum RealmManagerError: Error {
    case cantOpenLocalRealm
    case cantOpenSyncRealm
    case notExistDefaultData
}

class RealmManager {
    static let sharedInstance = RealmManager()
    var localRealm: Realm!
//    var syncRealm: Realm!

    class func bundleURL(name: String) -> URL? {
        return Bundle.main.url(forResource: name, withExtension: "realm")
    }
    
    class func openRealm() {
        // todo: check remote realm
        do {
            try RealmManager.sharedInstance.openLocalRealm()
        } catch {
            print(error)
        }
        
        // if dont has initial data
        
        if Device.getDevice() == nil {
            addDefaultData()
            print("Realm: Add default data")
        }
        
        copyInitialRealmData()
    }
    
    class func copyInitialRealmData() {
        //        let defaultURL = Realm.Configuration.defaultConfiguration.fileURL!
        //        if let v0URL = bundleURL(name: "default-v0") {
        //            do {
        //                try FileManager.default.copyItem(at: v0URL, to: defaultURL)
        //            } catch let error {
        //                print("error copying default-v0.realm: \(error)")
        //            }
        //        }
    }
    
    func openLocalRealm() throws {
        Realm.Configuration.defaultConfiguration = Realm.Configuration()
        do {
            self.localRealm = try Realm()
        } catch {
            throw RealmManagerError.cantOpenLocalRealm
        }
    }
    
//    func openSyncRealmWith(configuration: Realm.Configuration, user: SyncUser) throws {
//        do {
//            self.syncRealm = try Realm(configuration: configuration)
//        } catch {
//            throw RealmManagerError.canntOpenSyncRealm
//        }
//    }

    class func addDefaultData() {
        let device = Device.init(name: UIDevice.current.name, deviceIdentifier: "")
        RealmManager.addRealm(object: device)
        
        let organization = Organization.init(name: "test")
        RealmManager.addRealm(object: organization)
        
        for i in 1..<4 {
            let group = Group.init(name: "group" + String(i), organization: organization)
            RealmManager.addRealm(object: group)
        }
    }
    

    
    class func addRealm(object: Object) {
        do {
            guard let realm = RealmManager.sharedInstance.localRealm else {
                return
            }
            try realm.write {
                realm.add(object)
            }
        } catch let error {
            print("error write realm: \(error)")
        }
    }
    
    class func addRealm(objects: Object...) {
        do {
            guard let realm = RealmManager.sharedInstance.localRealm else {
                return
            }
            try realm.write {
                for object in objects {
                    realm.add(object)
                }
            }
        } catch let error {
            print("error write realm: \(error)")
        }
    }
    
    class func deleteRealm(object: Object) {
        do {
            guard let realm = RealmManager.sharedInstance.localRealm else {
                return
            }
            try realm.write {
                realm.delete(object)
            }
        } catch let error {
            print("error delete realm: \(error)")
        }
    }
}
