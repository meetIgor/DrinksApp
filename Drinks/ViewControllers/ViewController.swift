//
//  ViewController.swift
//  Drinks
//
//  Created by igor s on 12.08.2022.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Private Properties
    private var drink: Drink!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDrinks()
        
    }

    
    //MARK: - Private Methods
    private func fetchDrinks() {
        NetworkManager.shared.fetch(Drink.self, from: Link.cosmopolitanURL.rawValue) { [weak self] result in
            switch result {
            case .success(let drink):
                self?.drink = drink
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

