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
    
    private var activityIndicator: UIActivityIndicatorView?
    private var imageURL: URL? {
        didSet {
            ingredientImageView.image = nil
            updateImage()
        }
    }
    
    //MARK: - Life Cycles Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 9
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator = showSpinner(in: ingredientImageView)
    }
    
    // MARK: - Private Methods
    private func updateImage() {
        if let imageURL = imageURL {
            getImage(from: imageURL) { [weak self] result in
                switch result {
                case .success(let image):
                    if imageURL == self?.imageURL {
                        self?.ingredientImageView.image = image
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
            print("Image form CACHE: ", url.lastPathComponent)
            completion(.success(cacheImage))
            return
        }
        
        //download image from url
        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                completion(.success(image))
                print("Image from URL: ", url.lastPathComponent)
                ImageCacheManager.shared.setObject(image, forKey: url.lastPathComponent as NSString)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        //activityIndicator.center = view.center
        activityIndicator.frame = CGRect(x: view.frame.height / 2, y: view.frame.width / 2, width: 10, height: 10)
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    //MARK: - Public Methods
    func configure(with ingredient: String, and measure: String) {
        let link = (Link.ingredientImageURL.rawValue + ingredient + ".png")
            .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
        
        if UIScreen.main.bounds.height < 667 {
            ingredientTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            ingredientMeasureLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        } else if UIScreen.main.bounds.height < 736 {
            ingredientTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            ingredientMeasureLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        }
        
        ingredientTitleLabel.text = ingredient
        ingredientMeasureLabel.text = measure
        
        imageURL = URL(string: link)
        ingredientImageView.layer.cornerRadius = 10
    }
}
