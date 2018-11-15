//
//  TagViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/11/01.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import PDFKit
import UIKit

protocol TagDelegate {
    func addTag(tag: Tag) -> ()
    func removeTag(tag: Tag) -> ()
    func editTag(tag: Tag) -> ()
}

class TagViewController: UIViewController {
    var rightNavigationItems: [UIBarButtonItem]!
    var leftNavigationItems: [UIBarButtonItem]!
    var pdfView: PDFView!
    var pdfPage: PDFPage!
    var gestureView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tag"
        view.backgroundColor = .white
        
        prepareNavigationBar()
        preparePDFView()
        prepareGestureRecognizer()
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
        let addButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addAnnotation))
        rightNavigationItems.append(addButton)
        let saveButton = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: nil)
        rightNavigationItems.append(saveButton)
        navigationItem.rightBarButtonItems = rightNavigationItems
    }

    internal func preparePDFView() {
        pdfView = PDFView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        pdfView.autoScales = true
        pdfView.displaysPageBreaks = false
        pdfView.displayMode = .singlePage
        pdfView.document = getDocument()
        
        pdfPage = pdfView.currentPage
        
        view.addSubview(pdfView)
    }
    
    internal func prepareGestureRecognizer(){
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapPDFView))
        self.pdfView.addGestureRecognizer(tapGesture)
//        var longPressGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressPDFView))
//        longPressGesture.minimumPressDuration = 2.0
//        longPressGesture.allowableMovement = 150
//        self.pdfView.addGestureRecognizer(longPressGesture)
    }
}

extension TagViewController: TagDelegate {
    @objc func exitViewController() {
//        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//            let path = url.appendingPathComponent("output.pdf")
//            self.pdfPage.document?.write(to: path)
//        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tapPDFView(sender: UITapGestureRecognizer) {
        let tapPoint = sender.location(in: self.pdfView)
        print("x: ", tapPoint.x, ", y: ", tapPoint.y)
    }
    
    @objc func longPressPDFView() {
        
    }
    
    @objc func addAnnotation() {
        let addAnnotationVC = AddModalViewController()
        addAnnotationVC.delegate = self
        let addAnnotationNC = UINavigationController.init(rootViewController: addAnnotationVC)
        addAnnotationNC.modalTransitionStyle = .coverVertical
        addAnnotationNC.modalPresentationStyle = .formSheet
        addAnnotationNC.preferredContentSize = CGSize.init(width: 500, height: 500)
        self.present(addAnnotationNC, animated: true, completion: nil)
    }
    
    func addTag(tag: Tag) {
        let size = tag.getSize()
        let point = tag.getPoint()
        let textAnnotation = PDFAnnotation.init(bounds: CGRect.init(x: point.x, y: point.y, width: size.width, height: size.height), forType: .freeText, withProperties: nil)
        textAnnotation.contents = tag.description
        textAnnotation.backgroundColor = tag.color
        textAnnotation.color = tag.color
        textAnnotation.interiorColor = tag.color
        textAnnotation.font = UIFont.systemFont(ofSize: 45)

        pdfPage.addAnnotation(textAnnotation)
    }
    
    func removeTag(tag: Tag) {
    }
    
    func editTag(tag:Tag) {
    }
}
