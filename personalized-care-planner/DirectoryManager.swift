//
//  DirectoryManager.swift
//  personalized-care-planner
//
//  Created by omata on 2018/12/04.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation

class DirectoryManager {
    class func getDefaultTemplatePath() -> String? {
        guard let path = Bundle.main.path(forResource: "self-sheet", ofType: "pdf") else { return nil }
        return path
    }
    
    class func copyUserPDFToCacheDirectory(userId: String) throws {
        guard let pdfPath = saveFileURL else {
            do {
                try copyTemplateToCacheDirectory()
            } catch {
                print(error)
            }
            return
        }
        guard let path = cacheFileURL else { return}
        
        do {
            try FileManager.default.copyItem(at: pdfPath, to: path)
        } catch {
            print(error)
        }
    }
    
    class func copyTemplateToCacheDirectory() throws {
        guard let pdfPath = getDefaultTemplatePath() else { return }
        guard let path = cacheFileURL else { return }
        do {
            try FileManager.default.copyItem(at: URL(fileURLWithPath: pdfPath), to: path)
        } catch {
            print(error)
        }
    }
    
    /////////////
    ///// cache
    /////////////
    class var cacheDirectoryURL: URL? {
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
            return nil
        }
        return URL(fileURLWithPath: path).appendingPathComponent("cache")
    }
    
    class var cacheFileURL: URL? {
        guard let cacheDirectoryURL = cacheDirectoryURL else { return nil }
        return cacheDirectoryURL.appendingPathComponent("cache.pdf")
    }
    
    class func createCacheDirectoryIfNeed() throws {
        guard let cacheDirectoryURL = cacheDirectoryURL else { return }
        let fileManager = FileManager.default
        guard !fileManager.fileExists(atPath: cacheDirectoryURL.path) else { return }
        
        try fileManager.createDirectory(at: cacheDirectoryURL, withIntermediateDirectories: true, attributes: nil)
    }
    
    class func removeOldCacheFile() throws {
        guard let cacheURL = cacheFileURL else { return }
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: cacheURL.path) else { return }
        try fileManager.removeItem(at: cacheURL)
    }
    
    
    /////////////
    ///// save
    /////////////
    
    class func copyToSaveDirectory() -> URL? {
        guard let fromPath = cacheFileURL else { return nil }
        guard let toPath = saveFileURL else { return nil }
        
        do {
            try FileManager.default.copyItem(at: fromPath, to: toPath)
            return toPath
        } catch {
            assert(false, "copyToSaveDirectory false: \(error)")
        }
    }
    
    class var saveDirectoryURL: URL? {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return nil
        }
        
        return URL(fileURLWithPath: path).appendingPathComponent("Profile")
    }
    
    class var saveFileURL: URL? {
        guard let saveDirectoryURL = saveDirectoryURL else { return nil }
        let userId = "testid"
        let fileName = "self.pdf"
        return saveDirectoryURL.appendingPathComponent(userId).appendingPathComponent(fileName)
    }
    
    class func createSaveDirectoryIfNeed() throws {
        guard let saveDirectoryURL = saveDirectoryURL else { return }
        let fileManager = FileManager.default
        
        guard !fileManager.fileExists(atPath: saveDirectoryURL.path) else {
            return
        }
        
        try fileManager.createDirectory(at: saveDirectoryURL, withIntermediateDirectories: true, attributes: nil)
    }
    
    class func createProfileDirectoryIfNeed(userId: String) throws {
        guard let saveDirectoryURL = saveDirectoryURL else { return }
        let profileDirectoryURL = saveDirectoryURL.appendingPathComponent(userId)
        let fileManager = FileManager.default
        
        guard !fileManager.fileExists(atPath: profileDirectoryURL.path) else {
            return
        }
        
        try fileManager.createDirectory(at: profileDirectoryURL, withIntermediateDirectories: true, attributes: nil)
    }
}
