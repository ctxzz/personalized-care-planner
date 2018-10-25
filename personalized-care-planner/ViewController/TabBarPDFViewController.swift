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
    var tabItemHeight: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PDF"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        preparePDFView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDocument() -> PDFDocument? {
        guard let path = Bundle.main.path(forResource: "self-alone-sheet", ofType: "pdf") else {
            print("failed to get path.")
            return nil
        }
        
        let pdfURL = URL.init(fileURLWithPath: path)
        let document = PDFDocument.init(url: pdfURL)
        
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
