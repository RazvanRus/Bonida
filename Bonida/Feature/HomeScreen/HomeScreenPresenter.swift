//
//  HomeScreenPresenter.swift
//  Bonida
//
//  Created by Rus Razvan on 28/10/2018.
//  Copyright © 2018 Rus Razvan. All rights reserved.
//

import Foundation

private enum DestinationScreens {
    static let codesGeneration = "CodesGenerationViewController"
    static let codesGestion = "CodesGestionViewController"
    static let depositsGestion = "DepositsGestionViewController"
    static let itemsGestion = "ItemsGestionViewController"
}

protocol HomeScreenViewProtocol: class {
    func configure()
    func navigateTo(_ nextVCIdentifier: String)
}

class HomeScreenPresenter {
    private var view: HomeScreenViewProtocol!
    
    init(view: HomeScreenViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view.configure()
    }
    
    func codesGenerationButtonTapped() {
        view.navigateTo(DestinationScreens.codesGeneration)
    }
    
    func codesGestionButtonTapped() {
        view.navigateTo(DestinationScreens.codesGestion)
    }
    
    func depositsGestionButtonTapped() {
        view.navigateTo(DestinationScreens.depositsGestion)
    }
    
    func itemsGestionButtonTapped() {
        view.navigateTo(DestinationScreens.itemsGestion)
    }
}
