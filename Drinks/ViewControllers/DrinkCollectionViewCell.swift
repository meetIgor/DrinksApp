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
    
    private var activityIndicator: UIActivityIndicatorView?
    private var imageURL: URL? {
        didSet {
            drinkImageView.image = nil
            updateImage()
        }
    }
    
    //MARK: - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 9
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
    }
    
    override func awakeFromNib() {
        activityIndicator = showSpinner(in: drinkImageView)
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
    
    // MARK: - Private Methods
    private func updateImage() {
        if let imageURL = imageURL {
            getImage(from: imageURL) { [weak self] result in
                switch result {
                case .success(let image):
                    if imageURL == self?.imageURL {
                        self?.drinkImageView.image = image
                        self?.activityIndicator?.stopAnimating()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        //get image from cache
        if let cacheImage = ImageCacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
            completion(.success(cacheImage))
            return
        }
        
        //download image from url
        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                completion(.success(image))
                ImageCacheManager.shared.setObject(image, forKey: url.lastPathComponent as NSString)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .gray
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    //MARK: - Public Methods
    func configure(with drink: Сocktail) {
        if UIScreen.main.bounds.height < 667 {
            drinkTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
            drinkCategoryLabel.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        } else if UIScreen.main.bounds.height < 736 {
            drinkTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            drinkCategoryLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        }
        
        drinkTitleLabel.text = drink.drink
        drinkCategoryLabel.text = drink.category
        imageURL = URL(string: drink.drinkThumb)

        drinkImageView.layer.cornerRadius = 10
    }
}
