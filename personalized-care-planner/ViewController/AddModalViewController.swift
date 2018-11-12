//
//  AddModalViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/11/12.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import UIKit

class AddModalViewController: UIViewController {
    var leftNavigationItems: [UIBarButtonItem]!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Annotation"
        view.backgroundColor = .white
        
        prepareNavigationBar()
    }
    
}

extension AddModalViewController {
    internal func prepareNavigationBar() {
        /// LEFT Navigation
        leftNavigationItems = []
        let closeButton = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(closeModalView))
        leftNavigationItems.append(closeButton)
        navigationItem.leftBarButtonItems = leftNavigationItems
    }

}

extension AddModalViewController {
    @objc func closeModalView() -> () {
        dismiss(animated: true, completion: nil)
    }
}
