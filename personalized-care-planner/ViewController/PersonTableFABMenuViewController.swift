//
//  PersonTableFABMenuViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/10/24.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import UIKit
import Material
import Motion
import FontAwesome_swift

class PersonTableFABMenuViewController: FABMenuController {
    fileprivate let fabMenuSize = CGSize(width: 56, height: 56)
    fileprivate let bottomInset: CGFloat = 24
    fileprivate let rightInset: CGFloat = 24
    
    fileprivate var fabButton: FABButton!
    fileprivate var fabButtonSize = CGSize(width: 25, height: 25)
    fileprivate var templateFABMenuItem: FABMenuItem!
    fileprivate var personFABMenuItem: FABMenuItem!
    
    var rightNavigationItems: [UIBarButtonItem]!
    var leftNavigationItems: [UIBarButtonItem]!
    
    open override func prepare() {
        super.prepare()
        fabMenuBacking = .fade
        view.backgroundColor = .white
        prepareNavigationBar()
        prepareFABButton()
        prepareTemplateFABMenuItem()
        preparePersonFABMenuItem()
        prepareFABMenu()
    }
}

extension PersonTableFABMenuViewController {
    internal func prepareNavigationBar() {
        /// LEFT Navigation
        leftNavigationItems = []
        let settingButton = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: nil)
        leftNavigationItems.append(settingButton)
        navigationItem.leftBarButtonItems = leftNavigationItems
        
        /// RIGHT Navigation
        rightNavigationItems = []
        let searchButton = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: nil)
        rightNavigationItems.append(searchButton)
        navigationItem.rightBarButtonItems = rightNavigationItems
    }
    
    fileprivate func prepareFABButton() {
        fabButton = FABButton(image: Icon.cm.add, tintColor: .white)
        fabButton.backgroundColor = Color.red.base
        fabButton.pulseColor = .white
    }
    
    fileprivate func prepareTemplateFABMenuItem() {
        templateFABMenuItem = FABMenuItem()
        templateFABMenuItem.title = "Add Template"
        templateFABMenuItem.fabButton.image = UIImage.fontAwesomeIcon(name: .fileAlt, style: FontAwesomeStyle.solid, textColor: .white, size: fabButtonSize)
        templateFABMenuItem.fabButton.tintColor = .white
        templateFABMenuItem.fabButton.pulseColor = .white
        templateFABMenuItem.fabButton.backgroundColor = Color.green.base
        templateFABMenuItem.fabButton.addTarget(self, action: #selector(handleTemplateFABMenuItem(button:)), for: .touchUpInside)
    }
    
    fileprivate func preparePersonFABMenuItem() {
        personFABMenuItem = FABMenuItem()
        personFABMenuItem.title = "Add Person"
        personFABMenuItem.fabButton.image = UIImage.fontAwesomeIcon(name: .userPlus, style: FontAwesomeStyle.solid, textColor: .white, size: fabButtonSize)
        personFABMenuItem.fabButton.tintColor = .white
        personFABMenuItem.fabButton.pulseColor = .white
        personFABMenuItem.fabButton.backgroundColor = Color.blue.base
        personFABMenuItem.fabButton.addTarget(self, action: #selector(handleRemindersFABMenuItem(button:)), for: .touchUpInside)
    }
    
    fileprivate func prepareFABMenu() {
        fabMenu.fabButton = fabButton
        fabMenu.shadowColor = .black
        fabMenu.fabMenuItems = [templateFABMenuItem, personFABMenuItem]
        
        view.layout(fabMenu)
            .size(fabMenuSize)
            .bottom(bottomInset)
            .right(rightInset)
    }
}

extension PersonTableFABMenuViewController {
    @objc
    fileprivate func handleTemplateFABMenuItem(button: UIButton) {
        fabMenu.close()
        fabMenu.fabButton?.animate(.rotate(0))
    }
    
    @objc
    fileprivate func handleRemindersFABMenuItem(button: UIButton) {
        fabMenu.close()
        fabMenu.fabButton?.animate(.rotate(0))
        
        let personMVC = PersonModalViewController(mode: .add)
        let addPersonNC = UINavigationController.init(rootViewController: personMVC)
        addPersonNC.modalTransitionStyle = .coverVertical
        addPersonNC.modalPresentationStyle = .formSheet
        addPersonNC.preferredContentSize = CGSize.init(width: 500, height: 500)
        self.present(addPersonNC, animated: true, completion: nil)

    }
}

extension PersonTableFABMenuViewController {
    @objc
    open func fabMenuWillOpen(fabMenu: FABMenu) {
        fabMenu.fabButton?.animate(.rotate(135))
    }
    
    @objc
    open func fabMenuDidOpen(fabMenu: FABMenu) {
    }
    
    @objc
    open func fabMenuWillClose(fabMenu: FABMenu) {
        fabMenu.fabButton?.animate(.rotate(0))
    }
    
    @objc
    open func fabMenuDidClose(fabMenu: FABMenu) {
    }
    
    @objc
    open func fabMenu(fabMenu: FABMenu, tappedAt point: CGPoint, isOutside: Bool) {
        guard isOutside else {
            return
        }
        
        // Do something ...
    }
}
