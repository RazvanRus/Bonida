//
//  ItemsGestionScreenPresenter.swift
//  Bonida
//
//  Created by Rus Razvan on 28/10/2018.
//  Copyright © 2018 Rus Razvan. All rights reserved.
//

import Foundation

protocol ItemsGestionViewProtocol: class {
    func configure()
}

class ItemsGestionPresenter {
    private var view: ItemsGestionViewProtocol!
    
    init(view: ItemsGestionViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view.configure()
    }
}
