//
//  IngredientCollectionViewCell.swift
//  Drinks
//
//  Created by igor s on 13.08.2022.
//

import UIKit

class IngredientCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IB Outlets
    @IBOutlet weak var ingredientImageView: UIImageView!
    
    @IBOutlet weak var ingredientTitleLabel: UILabel!
    @IBOutlet weak var ingredientMeasureLabel: UILabel!
    
    //NARK: - Life Cycles Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 9
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
    }
    
    //MARK: - Public Properties
    func configure(with ingredient: String, and measure: String) {
        let link = Link.ingredientImageURL.rawValue + ingredient + ".png"
        let ingredientImgURL2 = link.addingPercentEncoding(
            withAllowedCharacters: NSCharacterSet.urlQueryAllowed
        )
        
        if UIScreen.main.bounds.height < 667 {
            ingredientTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            ingredientMeasureLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        } else if UIScreen.main.bounds.height < 736 {
            ingredientTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            ingredientMeasureLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        }
        
        ingredientTitleLabel.text = ingredient
        ingredientMeasureLabel.text = measure
        
        NetworkManager.shared.fetchImage(from: ingredientImgURL2) { [unowned self] result in
            switch result {
            case .success(let imageData):
                self.ingredientImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
        
        ingredientImageView.layer.cornerRadius = 10
    }
}
