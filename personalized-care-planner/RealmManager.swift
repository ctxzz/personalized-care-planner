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
    case canntOpenLocalRealm
    case canntOpenSyncRealm
    case notExistDefaultData
}

class RealmManager {
    static let sharedInstance = RealmManager()
    var localRealm: Realm!
//    var syncRealm: Realm!

    class func bundleURL(name: String) -> URL? {
        return Bundle.main.url(forResource: name, withExtension: "realm")
    }
    
    func openRealm() {
        // todo: check remote realm
        do {
            try RealmManager.sharedInstance.openLocalRealm()
        } catch {
            print(error)
        }
        
        // if dont has initial data
        copyInitialRealmData()
    }
    
    func copyInitialRealmData() {
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
            throw RealmManagerError.canntOpenLocalRealm
        }
    }
    
//    func openSyncRealmWith(configuration: Realm.Configuration, user: SyncUser) throws {
//        do {
//            self.syncRealm = try Realm(configuration: configuration)
//        } catch {
//            throw RealmManagerError.canntOpenSyncRealm
//        }
//    }

    
}
