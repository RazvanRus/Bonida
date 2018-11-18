//
//  CodesGestionPresenter.swift
//  Bonida
//
//  Created by Rus Razvan on 28/10/2018.
//  Copyright © 2018 Rus Razvan. All rights reserved.
//

import Foundation

protocol CodesGestionViewProtocol: class {
    func configure()
    func configureTableView()
    func reloadData()
    func reloadSection(_ sectionNumber: Int)
    func deleteRow(_ rowNumber: Int, inSection sectionNumber: Int)
    func deleteSection(_ sectionNumber: Int)
    func presentAddNewItemScreen(withDelegate delegate: AddNewItemProtocol)
}

protocol AddNewItemProtocol: class {
    func newItemAdded(_ item: Item)
}

class CodesGestionPresenter {
    private var view: CodesGestionViewProtocol!
    private var items: [Item] = []
    private var itemsExpended: [Bool] = []
    private let itemsGateway = ItemGateway.sharedInstance
    
    init(view: CodesGestionViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view.configure()
        itemsGateway.fetchItems(completion: { (items) in
            self.items = items
            for _ in items { self.itemsExpended.append(false) }
            self.view.configureTableView()
        })
    }
    
    func numberOfSections() -> Int {
        return items.count
    }
    
    func itemForSection(_ itemIndex: Int) -> String {
        return items[itemIndex].name
    }
    
    func numberOfItems(inSection itemIndex: Int) -> Int {
        return items[itemIndex].subItems.count
    }
    
    func numberOfItemsThatShouldBeDisplayed(inSection itemIndex: Int) -> Int {
        return itemsExpended[itemIndex] ? items[itemIndex].subItems.count : 0
    }
    
    func item(forRow subItemIndex: Int, inSection itemIndex: Int) -> String {
        return items[itemIndex].subItems[subItemIndex].name
    }
    
    func sectionTapped(_ itemIndex: Int) {
        itemsExpended[itemIndex] = !itemsExpended[itemIndex]
        view.reloadSection(itemIndex)
    }
    
    func deleteButtonTapped(forRow subItemIndex: Int, inSection itemIndex: Int) {
        items[itemIndex].deleteSubitem(at: subItemIndex)
        view.deleteRow(subItemIndex, inSection: itemIndex)
    }
    
    func deleteButtonTapped(forSection itemIndex: Int) {
        items.remove(at: itemIndex)
        itemsExpended.remove(at: itemIndex)
        view.deleteSection(itemIndex)
    }
    
    func addNewItemButtonTapped() {
        view.presentAddNewItemScreen(withDelegate: self)
    }
}

// MARK: AddNewItemProtocol extension

extension CodesGestionPresenter: AddNewItemProtocol {
    func newItemAdded(_ item: Item) {
        items.append(item)
        itemsExpended.append(false)
        view.reloadData()
    }
}
