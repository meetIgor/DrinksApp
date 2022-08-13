//
//  ViewController.swift
//  Drinks
//
//  Created by igor s on 12.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var drinksTypeLabel: UILabel!
    
    @IBOutlet weak var drinkCollectionView: UICollectionView!
    
    //MARK: - Private Properties
    private var drink = Drink(drinks: [])
    
    //MAR: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDrinks()
        drinkCollectionView.delegate = self
        drinkCollectionView.dataSource = self
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let coctailVC = segue.destination as? CoctailViewController else { return }
        guard let coctail = sender as? Coctail else { return }
        coctailVC.coctail = coctail
    }
    
    //MARK: - Private Methods
    private func fetchDrinks() {
        NetworkManager.shared.fetch(Drink.self, from: Link.daiquiriURL.rawValue) { [weak self] result in
            switch result {
            case .success(let drink):
                self?.drink = drink
                self?.drinkCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - Collection View Methods
extension ViewController: UICollectionViewDelegate,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        drink.drinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = drinkCollectionView.dequeueReusableCell(
                withReuseIdentifier: "drinkCell",
                for: indexPath
            ) as? DrinkCollectionViewCell else { return UICollectionViewCell() }
        
        let coctail = drink.drinks[indexPath.item]
        cell.configure(with: coctail)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.galleryItemWidth, height: collectionView.frame.height * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coctail = drink.drinks[indexPath.item]
        performSegue(withIdentifier: "showCoctailDetails", sender: coctail)
    }
}
