//
//  AddNewItemScreenViewController.swift
//  Bonida
//
//  Created by Rus Razvan on 05/11/2018.
//  Copyright © 2018 Rus Razvan. All rights reserved.
//

import UIKit

private enum Constants {
    static let rowNumberForAddCell = 0
    static let cellIdentifierForAddCell = "AddSubItemTableViewCell"
    static let cellIdentifierForDisplayCell = "ItemTableViewCell"
}

class AddNewItemScreenViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var itemsTableView: UITableView!
    
    var delegate: AddNewItemProtocol?
    private var presenter: AddNewItemScreenPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = AddNewItemScreenPresenter(view: self)
        presenter.viewDidLoad()
    }
    
    private func updateLocalisation() {
        
    }
    
    private func configureTableView() {
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.bounces = false
    }
    
    @IBAction func addItemButtonTapped(_ sender: Any) {
        if let itemName = titleTextField.text, !itemName.isEmpty {
            presenter.addItemButtonTapped(itemName)
        }
    }
}


// MARK: AddNewItemViewProtocol extension

extension AddNewItemScreenViewController: AddNewItemViewProtocol {
    func configure() {
        updateLocalisation()
        configureTableView()
    }
    
    func reloadData() {
        itemsTableView.reloadData()
    }
    
    func passNewItem(_ item: Item) {
        delegate?.newItemAdded(item)
    }
    
    func dismissScreen() {
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK: AddSubItemCellProtocol extension

extension AddNewItemScreenViewController: AddSubItemCellProtocol {
    func subItemAdded(_ subItemName: String) {
        presenter.subItemAdded(subItemName)
    }
}


// MARK: TableView delegate extension

extension AddNewItemScreenViewController: UITableViewDelegate {
    
}


// MARK: TableView dataSource extension

extension AddNewItemScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems() + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == Constants.rowNumberForAddCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifierForAddCell) as? AddSubItemTableViewCell {
                cell.delegate = self
                cell.selectionStyle = .none
                cell.configure()
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifierForDisplayCell) as? ItemTableViewCell {
                cell.titleLabel.text = presenter.subItem(forRow: indexPath.row - 1)
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
}
