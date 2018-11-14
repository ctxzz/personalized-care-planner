//
//  File.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/11/15.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import UIKit

protocol TextFieldViewCellDelegate {
    func textFieldDidEndEditing(cell: TextFieldViewCell, value: String) -> ()
}

class TextFieldViewCell: UITableViewCell {
    var delegate: TextFieldViewCellDelegate! = nil
    var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textField = UITextField()
        self.textField.delegate = self
        self.textField.frame = CGRect.init(x: 10, y: 0, width: 490, height: self.frame.height)
        addSubview(textField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellText(value: String?) {
        textField.text = value
    }
}

extension TextFieldViewCell: UITextFieldDelegate {
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    internal func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate.textFieldDidEndEditing(cell: self, value: textField.text!)
    }
}
