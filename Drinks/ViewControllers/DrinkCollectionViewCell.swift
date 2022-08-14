//
//  DrinkCollectionViewCell.swift
//  Drinks
//
//  Created by igor s on 13.08.2022.
//

import UIKit

class DrinkCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IB Outlets
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkTitleLabel: UILabel!
    @IBOutlet weak var drinkCategoryLabel: UILabel!
    
    //MARK: - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 9
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
    }
    
    //MARK: - IB ACtions
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sender.setImage(UIImage.init(systemName: "heart.fill"), for: .normal)
            sender.tag = 1
        default:
            sender.setImage(UIImage.init(systemName: "heart"), for: .normal)
            sender.tag = 0
        }
    }
    
    //MARK: - Public Methods
    func configure(with drink: Coctail) {
        if UIScreen.main.bounds.height < 667 {
            drinkTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
            drinkCategoryLabel.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        } else if UIScreen.main.bounds.height < 736 {
            drinkTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            drinkCategoryLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        }
        
        drinkTitleLabel.text = drink.drink
        drinkCategoryLabel.text = drink.category
        
        NetworkManager.shared.fetchImage(from: drink.drinkThumb) { [unowned self] result in
            switch result {
            case .success(let imageData):
                self.drinkImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
        
        drinkImageView.layer.cornerRadius = 10
    }
}
