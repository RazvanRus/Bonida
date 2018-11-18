//
//  Item.swift
//  Bonida
//
//  Created by Rus Razvan on 28/10/2018.
//  Copyright © 2018 Rus Razvan. All rights reserved.
//

import Foundation

class Item {
    var name: String
    var subItems: [SubItem]
    var code: String
    
    init(name: String) {
        self.name = name
        self.subItems = []
        self.code = name
    }
    
    func addSubItem(subItemName: String) {
        let subItem = SubItem(name: subItemName, parentCode: code)
        subItems.append(subItem)
    }
    
    func deleteSubitem(at index: Int) {
        subItems.remove(at: index)
    }
}
