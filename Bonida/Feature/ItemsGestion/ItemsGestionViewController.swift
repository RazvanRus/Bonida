//
//  ItemsGestionViewController.swift
//  Bonida
//
//  Created by Rus Razvan on 28/10/2018.
//  Copyright © 2018 Rus Razvan. All rights reserved.
//

import UIKit

class ItemsGestionViewController: UIViewController {
    private var presenter: ItemsGestionPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ItemsGestionPresenter(view: self)
        presenter.viewDidLoad()
    }
    
    private func updateLocalisation() {
        // TODO: update localisation for items
    }
}


// MARK: - ItemsGestionViewProtocol extension -

extension ItemsGestionViewController: ItemsGestionViewProtocol {
    func configure() {
        updateLocalisation()
    }
}
