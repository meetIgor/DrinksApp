//
//  CoctailViewController.swift
//  Drinks
//
//  Created by igor s on 13.08.2022.
//

import UIKit

class CoctailViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var ingredientsCollectionView: UICollectionView!
    @IBOutlet weak var coctailImageView: UIImageView!
    
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var glassLabel: UILabel!
    
    //MARK: - Public Properties
    var cocktail: Сocktail!
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsCollectionView.delegate = self
        ingredientsCollectionView.dataSource = self
        
        title = cocktail.drink
        instructionLabel.text = "Instruction: " + cocktail.instructions
        glassLabel.text = "Glass: " + cocktail.glass
        
        NetworkManager.shared.fetchData(from: cocktail.drinkThumb) { [ unowned self ] result in
            switch result {
            case .success(let imageData):
                self.coctailImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        coctailImageView.layer.cornerRadius = 10
    }
}

//MARK: - Collection View Methods
extension CoctailViewController:
    UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cocktail.ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = ingredientsCollectionView.dequeueReusableCell(
                withReuseIdentifier: "ingredientCell",
                for: indexPath
            ) as? IngredientCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(
            with: cocktail.ingredients[indexPath.item],
            and: cocktail.measures[indexPath.item]
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.ingredietnsGalleryItemWidth, height: collectionView.frame.height * 0.8)
    }
    
}
