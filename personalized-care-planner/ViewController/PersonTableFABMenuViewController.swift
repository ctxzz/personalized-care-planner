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

class PersonTableFABMenuViewController: FABMenuController {
    fileprivate let fabMenuSize = CGSize(width: 56, height: 56)
    fileprivate let bottomInset: CGFloat = 24
    fileprivate let rightInset: CGFloat = 24
    
    fileprivate var fabButton: FABButton!
    fileprivate var notesFABMenuItem: FABMenuItem!
    fileprivate var remindersFABMenuItem: FABMenuItem!
    
    var rightNavigationItems: [UIBarButtonItem]!
    var leftNavigationItems: [UIBarButtonItem]!
    
    open override func prepare() {
        super.prepare()
        fabMenuBacking = .fade
        view.backgroundColor = .white
        prepareNavigationBar()
        prepareFABButton()
        prepareNotesFABMenuItem()
        prepareRemindersFABMenuItem()
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
    
    fileprivate func prepareNotesFABMenuItem() {
        notesFABMenuItem = FABMenuItem()
        notesFABMenuItem.title = "Audio Library"
        notesFABMenuItem.fabButton.image = Icon.cm.pen
        notesFABMenuItem.fabButton.tintColor = .white
        notesFABMenuItem.fabButton.pulseColor = .white
        notesFABMenuItem.fabButton.backgroundColor = Color.green.base
        notesFABMenuItem.fabButton.addTarget(self, action: #selector(handleNotesFABMenuItem(button:)), for: .touchUpInside)
    }
    
    fileprivate func prepareRemindersFABMenuItem() {
        remindersFABMenuItem = FABMenuItem()
        remindersFABMenuItem.title = "Reminders"
        remindersFABMenuItem.fabButton.image = Icon.cm.bell
        remindersFABMenuItem.fabButton.tintColor = .white
        remindersFABMenuItem.fabButton.pulseColor = .white
        remindersFABMenuItem.fabButton.backgroundColor = Color.blue.base
        remindersFABMenuItem.fabButton.addTarget(self, action: #selector(handleRemindersFABMenuItem(button:)), for: .touchUpInside)
    }
    
    fileprivate func prepareFABMenu() {
        fabMenu.fabButton = fabButton
        fabMenu.shadowColor = .black
        fabMenu.fabMenuItems = [notesFABMenuItem, remindersFABMenuItem]
        
        view.layout(fabMenu)
            .size(fabMenuSize)
            .bottom(bottomInset)
            .right(rightInset)
    }
}

extension PersonTableFABMenuViewController {
    @objc
    fileprivate func handleNotesFABMenuItem(button: UIButton) {
        fabMenu.close()
        fabMenu.fabButton?.animate(.rotate(0))
    }
    
    @objc
    fileprivate func handleRemindersFABMenuItem(button: UIButton) {
        fabMenu.close()
        fabMenu.fabButton?.animate(.rotate(0))
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
