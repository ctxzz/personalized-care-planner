//
//  TabBarPDFViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/10/20.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import UIKit
import PDFKit

class TabBarPDFViewController: UIViewController {
    var pdfView: PDFView!
    var userId = "testUser"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PDF"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let pdfView = self.view.subviews.first as? PDFView  {
            pdfView.removeFromSuperview()
        }
        preparePDFView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDocument() -> PDFDocument? {
        do {
            try DirectoryManager.createTemplateDirectoryIfNeed(templateName: "Personality")
        } catch {
            print(error)
            return nil
        }
        
        guard let path = DirectoryManager.getSaveFileURL(template: "Personality", fileId: userId) else {
            print("failed to get path.")
            return nil
        }
        
        let document = PDFDocument.init(url: path)
        
        return document
    }
}

extension TabBarPDFViewController {
    internal func preparePDFView() {
        pdfView = PDFView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        pdfView.autoScales = true
        pdfView.displaysPageBreaks = false
        pdfView.displayMode = .singlePage
        pdfView.document = getDocument()
        view.addSubview(pdfView)
    }
}
