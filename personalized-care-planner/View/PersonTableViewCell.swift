//
//  PersonTableViewCell.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/10/19.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import UIKit

class PersonTableViewCell: UITableViewCell {
    var name: String!
    var photo: UIImage?
    var updateDate: Date!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .gray
        name = ""
        photo = nil
        updateDate = Date.init()
        
        
    }
}
