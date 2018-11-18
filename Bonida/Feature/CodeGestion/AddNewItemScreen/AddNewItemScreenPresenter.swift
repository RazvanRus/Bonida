//
//  AddNewItemScreenPresenter.swift
//  Bonida
//
//  Created by Rus Razvan on 05/11/2018.
//  Copyright © 2018 Rus Razvan. All rights reserved.
//

import Foundation

protocol AddSubItemCellProtocol: class {
    func subItemAdded(_ subItemName: String)
}

protocol AddNewItemViewProtocol: class {
    func configure()
    func reloadData()
    func passNewItem(_ item: Item)
    func dismissScreen()
}

class AddNewItemScreenPresenter {
    var view: AddNewItemViewProtocol!
    private var subItems: [String] = []
    
    init(view: AddNewItemViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.configure()
    }
    
    func numberOfItems() -> Int {
        return subItems.count
    }
    
    func subItem(forRow row: Int) -> String {
        return subItems[row]
    }
    
    func subItemAdded(_ subItemName: String) {
        subItems.append(subItemName)
        view.reloadData()
    }
    
    func addItemButtonTapped(_ itemName: String) {
        let item = createNewItem(itemName, subItemsNames: subItems)
        view.passNewItem(item)
        view.dismissScreen()
    }
    
    private func createNewItem(_ itemName: String, subItemsNames: [String]) -> Item {
        let item = Item(name: itemName)
        for subItemName in subItemsNames {
            item.addSubItem(subItemName: subItemName)
        }
        return item
    }
}
