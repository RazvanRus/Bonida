//
//  CodesGestionViewController.swift
//  Bonida
//
//  Created by Rus Razvan on 28/10/2018.
//  Copyright © 2018 Rus Razvan. All rights reserved.
//

import UIKit

class CodesGestionViewController: UIViewController {
    @IBOutlet private weak var itemsTableView: UITableView!
    
    private var presenter: CodesGestionPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = CodesGestionPresenter(view: self)
        presenter.viewDidLoad()
    }
    
    private func updateLocalisation() {
        // TODO: update localisation for items
    }
    
    @IBAction private func addButtonTapped(_ sender: Any) {
        presenter.addNewItemButtonTapped()
    }
}


// MARK: - CodesGestionViewProtocol extension -

extension CodesGestionViewController: CodesGestionViewProtocol {
    func configure() {
        updateLocalisation()
    }
    
    func configureTableView() {
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.reloadData()
    }
    
    func reloadData() {
        itemsTableView.reloadData()
    }
    
    func reloadSection(_ sectionNumber: Int) {
        itemsTableView.beginUpdates()
        itemsTableView.reloadSections(NSIndexSet(index: sectionNumber) as IndexSet, with: .automatic)
        itemsTableView.endUpdates()
    }
    
    func deleteRow(_ rowNumber: Int, inSection sectionNumber: Int) {
        itemsTableView.beginUpdates()
        itemsTableView.deleteRows(at: [IndexPath(row: rowNumber, section: sectionNumber)], with: .automatic)
        itemsTableView.reloadSections(NSIndexSet(index: sectionNumber) as IndexSet, with: .automatic)
        itemsTableView.endUpdates()
    }
    
    func deleteSection(_ sectionNumber: Int) {
        itemsTableView.beginUpdates()
        itemsTableView.deleteSections(NSIndexSet(index: sectionNumber) as IndexSet, with: .automatic)
        itemsTableView.reloadData()
        itemsTableView.endUpdates()
    }
    
    func presentAddNewItemScreen(withDelegate delegate: AddNewItemProtocol) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "AddNewItemScreenViewController") as? AddNewItemScreenViewController {
            controller.delegate = delegate
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}


// MARK: - TableView delegate extension -

extension CodesGestionViewController: UITableViewDelegate {
    
}


// MARK: - TableView data source extension -

extension CodesGestionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ItemTableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80),
                                             title: presenter.itemForSection(section),
                                             count: presenter.numberOfItems(inSection: section))
        
        headerView.delegate = self
        headerView.headerIndex = section
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItemsThatShouldBeDisplayed(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as? ItemTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = presenter.item(forRow: indexPath.row, inSection: indexPath.section)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteButtonTapped(forRow: indexPath.row, inSection: indexPath.section)
        }
    }
}


// MARK: - HeaderView tap delegate extension -

extension CodesGestionViewController: ItemTableHeaderProtocol {
    func headerWasTapped(_ headerIndex: Int) {
        presenter.sectionTapped(headerIndex)
    }
    
    func headerDeleteButtonTapped(_ headerIndex: Int) {
        presenter.deleteButtonTapped(forSection: headerIndex)
    }
}
