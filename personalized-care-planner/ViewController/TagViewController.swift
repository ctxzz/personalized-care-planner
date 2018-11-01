//
//  TagViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/11/01.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import PDFKit

class TagViewController: UIViewController {
    var rightNavigationItems: [UIBarButtonItem]!
    var leftNavigationItems: [UIBarButtonItem]!
    var pdfView: PDFView!
    var pdfPage: PDFPage!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tag"
        view.backgroundColor = .white
        
        prepareNavigationBar()
        preparePDFView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDocument() -> PDFDocument? {
        guard let path = Bundle.main.path(forResource: "self-sheet", ofType: "pdf") else {
            print("failed to get path.")
            return nil
        }
        
        let pdfURL = URL.init(fileURLWithPath: path)
        let document = PDFDocument.init(url: pdfURL)
        
        return document
    }
}

extension TagViewController {
    internal func prepareNavigationBar() {
        /// LEFT Navigation
        leftNavigationItems = []
        let exitButton = UIBarButtonItem.init(title: "exit", style: .plain, target: self, action: #selector(exitViewController))
        leftNavigationItems.append(exitButton)
        navigationItem.leftBarButtonItems = leftNavigationItems
        /// RIGHT Navigation
        rightNavigationItems = []
        navigationItem.rightBarButtonItems = rightNavigationItems
    }

    internal func preparePDFView() {
        pdfView = PDFView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        pdfView.autoScales = true
        pdfView.displaysPageBreaks = false
        pdfView.displayMode = .singlePage
        pdfView.document = getDocument()
        
        pdfPage = pdfView.currentPage
        let test = PDFAnnotation.init(bounds: CGRect.init(x: 100, y: 100, width: 200, height: 200), forType: .circle, withProperties: nil)
        pdfPage.addAnnotation(test)
        
        view.addSubview(pdfView)
    }
}

extension TagViewController {
    @objc func exitViewController() {
//        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//            let path = url.appendingPathComponent("output.pdf")
//            self.pdfPage.document?.write(to: path)
//        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
