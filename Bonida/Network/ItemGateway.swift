//
//  ItemGateway.swift
//  Bonida
//
//  Created by Rus Razvan on 18/11/2018.
//  Copyright © 2018 Rus Razvan. All rights reserved.
//

import Foundation

typealias FetchItemsCompletionHandler = ([Item]) -> Void

class ItemGateway {
    static let sharedInstance = ItemGateway()
    
    private init() {}
    
    func fetchItems(completion: @escaping FetchItemsCompletionHandler) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            completion(self.retreaveAllItems())
        }
    }
    
    private func retreaveAllItems() -> [Item] {
        var array = [self.createMockItem()]
        array.append(self.createMockItem2())
        array.append(self.createMockItem())
        array.append(self.createMockItem2())
        array.append(self.createMockItem())
        return array
    }
    
    
    private func createMockItem() -> Item {
        let item = Item(name: "Mock Item")
        item.addSubItem(subItemName: "SubItem1")
        item.addSubItem(subItemName: "SubItem2")
        item.addSubItem(subItemName: "SubItem3")
        item.addSubItem(subItemName: "SubItem4")
        item.addSubItem(subItemName: "SubItem5")
        
        return item
    }
    
    private func createMockItem2() -> Item {
        let item = Item(name: "Mock Item")
        item.addSubItem(subItemName: "SubItem1")
        item.addSubItem(subItemName: "SubItem4")
        item.addSubItem(subItemName: "SubItem5")
        
        return item
    }
}
