//
//  DirectoryManager.swift
//  personalized-care-planner
//
//  Created by omata on 2018/12/04.
//  Copyright © 2018 Kirilab. All rights reserved.
//


/// Directory hierarchy
///  /Documents
///   | /Templates
///   | /cache
///   | /Personality
///   |  a.pdf
///   |  b.pdf
///   |  ...
///   | /template2
///   | /template3
///   |  ...
///


import Foundation

class DirectoryManager {
    /////////////
    ///// Templates
    /////////////
    
    class func setDefaultDocumentToTemplates() {
        guard let path = Bundle.main.path(forResource: "Personality", ofType: "pdf") else { return }
        let from = URL(fileURLWithPath: path)
        guard var to = templatesDirectoryURL else { return }
        to = to.appendingPathComponent(from.lastPathComponent)
        
        do {
            try FileManager.default.copyItem(at: from, to: to)
        } catch {
            print(error)
        }
    }
    
    class var templatesDirectoryURL: URL? {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return nil
        }
        return URL(fileURLWithPath: path).appendingPathComponent("Templates")
    }
    
    /////  create /Templates
    class func createTemplatesDirectoryIfNeed() throws {
        guard let templatesDirectoryURL = templatesDirectoryURL else { return }
        let fileManager = FileManager.default
        guard !fileManager.fileExists(atPath: templatesDirectoryURL.path) else { return }
        
        try fileManager.createDirectory(at: templatesDirectoryURL, withIntermediateDirectories: true, attributes: nil)
    }
    
    /////  get /Templates/[template].pdf
    class func getTemplateFileURL(templateName: String) -> URL? {
        guard let templatesDirectoryURL = templatesDirectoryURL else { return nil }
        return templatesDirectoryURL.appendingPathComponent(templateName + ".pdf")
    }

    /////  get /Personlaity, etc...
    class func getTemplateDirectoryURL(templateName: String) -> URL? {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return nil
        }
        return URL(fileURLWithPath: path).appendingPathComponent(templateName)
    }
    
    ////  create /Personlaity, etc...
    class func createTemplateDirectoryIfNeed(templateName: String) throws {
        guard let templateDirectoryURL = getTemplateDirectoryURL(templateName: templateName) else { return }
        let fileManager = FileManager.default
        guard !fileManager.fileExists(atPath: templateDirectoryURL.path) else { return }
        
        try fileManager.createDirectory(at: templateDirectoryURL, withIntermediateDirectories: true, attributes: nil)
    }

    class func copyTemplateToCacheDirectory(templateName: String) throws {
        guard let templatePath = getTemplateFileURL(templateName: templateName) else { return }
        guard let cachePath = cacheFileURL else { return }
        do {
            try FileManager.default.copyItem(at: templatePath, to: cachePath)
        } catch {
            print(error)
        }
    }
    
    class func copyUserPDFToCacheDirectory(template: String, fileId: String) throws {
        guard let pdfPath = getUserFileURL(template: template, fileId: fileId) else {
            do {
                try copyTemplateToCacheDirectory(templateName: template)
            } catch {
                print(error)
            }
            return
        }
        guard let path = cacheFileURL else { return }
        
        do {
            try FileManager.default.copyItem(at: pdfPath, to: path)
        } catch {
            print(error)
        }
    }
    
    class func getUserFileURL(template: String, fileId: String) -> URL? {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return nil }
        let userFileURL = URL(fileURLWithPath: path).appendingPathComponent(template).appendingPathComponent(fileId)
        if !FileManager.default.fileExists(atPath: userFileURL.path) {
            return nil
        }
  
        return userFileURL
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
    
    class func copyToSaveDirectory(template: String, fileId: String) -> URL? {
        guard let fromPath = cacheFileURL else { return nil }
        guard let toPath = getSaveFileURL(template: template, fileId: fileId) else { return nil }
        
        do {
            try FileManager.default.copyItem(at: fromPath, to: toPath)
            return toPath
        } catch {
            assert(false, "copyToSaveDirectory false: \(error)")
        }
    }
    
    class func getSaveFileURL(template: String, fileId: String) -> URL? {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return nil }
        return URL(fileURLWithPath: path).appendingPathComponent(template).appendingPathComponent(fileId + ".pdf")
    }
    
//    class var saveDirectoryURL: URL? {
//        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
//            return nil
//        }
//
//        return URL(fileURLWithPath: path).appendingPathComponent("Profile")
//    }
//
//    class var saveFileURL: URL? {
//        guard let saveDirectoryURL = saveDirectoryURL else { return nil }
//        let userId = "testid.pdf"
//        return saveDirectoryURL.appendingPathComponent(userId)
//    }
    
//    class func createSaveDirectoryIfNeed() throws {
//        guard let saveDirectoryURL = saveDirectoryURL else { return }
//        let fileManager = FileManager.default
//
//        guard !fileManager.fileExists(atPath: saveDirectoryURL.path) else {
//            return
//        }
//
//        try fileManager.createDirectory(at: saveDirectoryURL, withIntermediateDirectories: true, attributes: nil)
//    }
//
//    class func createProfileDirectoryIfNeed(userId: String) throws {
//        guard let saveDirectoryURL = saveDirectoryURL else { return }
//        let profileDirectoryURL = saveDirectoryURL.appendingPathComponent(userId)
//        let fileManager = FileManager.default
//
//        guard !fileManager.fileExists(atPath: profileDirectoryURL.path) else {
//            return
//        }
//
//        try fileManager.createDirectory(at: profileDirectoryURL, withIntermediateDirectories: true, attributes: nil)
//    }
}
