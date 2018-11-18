//
//  ViewController.swift
//  Bonida
//
//  Created by Rus Razvan on 28/10/2018.
//  Copyright © 2018 Rus Razvan. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    @IBOutlet weak var codesGenerationButton: UIButton!
    @IBOutlet weak var codesGestionButton: UIButton!
    @IBOutlet weak var itemsGestionButton: UIButton!
    @IBOutlet weak var depositsGestionButton: UIButton!
    
    private var presenter: HomeScreenPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = HomeScreenPresenter(view: self)
        presenter.viewDidLoad()
    }
    
    private func updateLocalisation() {
        // TODO: perform localisation update for buttons label, labels, etc.
    }
}


// MARK: - user interaction extenstion -

extension HomeScreenViewController {
    @IBAction func codesGenerationButtonTapped(_ sender: Any) {
        presenter.codesGenerationButtonTapped()
    }
    
    @IBAction func codesGestionButtonTapped(_ sender: Any) {
        presenter.codesGestionButtonTapped()
    }
    
    @IBAction func itemsGestionButtonTapped(_ sender: Any) {
        presenter.itemsGestionButtonTapped()
    }
    
    @IBAction func depositsGestionButtonTapped(_ sender: Any) {
        presenter.depositsGestionButtonTapped()
    }
}


// MARK: - HomeScreenViewProtocol extension -

extension HomeScreenViewController: HomeScreenViewProtocol {
    func configure() {
        updateLocalisation()
    }
    
    func navigateTo(_ nextVCIdentifier: String) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: nextVCIdentifier)
        navigationController?.pushViewController(controller, animated: true)
    }
}
