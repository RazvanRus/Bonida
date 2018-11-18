//
//  SubItem.swift
//  Bonida
//
//  Created by Rus Razvan on 28/10/2018.
//  Copyright © 2018 Rus Razvan. All rights reserved.
//

import Foundation

struct SubItem {
    var name: String
    var code: String
    
    init(name: String, parentCode: String) {
        self.name = name
        self.code = parentCode + "/" + name
    }
}
