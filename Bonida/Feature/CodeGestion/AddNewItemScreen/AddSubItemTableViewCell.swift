//
//  AddSubitemTableViewCell.swift
//  Bonida
//
//  Created by Rus Razvan on 05/11/2018.
//  Copyright © 2018 Rus Razvan. All rights reserved.
//

import UIKit

class AddSubItemTableViewCell: UITableViewCell {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var delegate: AddSubItemCellProtocol?
    
    func configure() {
        updateLocalisation()
    }
    
    func updateLocalisation() {
        
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if let subItemName = titleTextField.text, !subItemName.isEmpty {
            titleTextField.text = ""
            delegate?.subItemAdded(subItemName)
        }
    }
}
