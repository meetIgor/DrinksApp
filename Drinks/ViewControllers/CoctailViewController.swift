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
    
    // MARK: - Private Properties
    
    private var activityIndicator: UIActivityIndicatorView?

    private var imageURL: URL? {
        didSet {
            coctailImageView.image = nil
            updateImage()
        }
    }
    
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
        activityIndicator = showSpinner(in: coctailImageView)
        imageURL = URL(string: cocktail.drinkThumb)
        coctailImageView.layer.cornerRadius = 10
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityIndicator?.frame = CGRect(x: coctailImageView.frame.width / 2, y: coctailImageView.frame.height / 2, width: 10, height: 10)
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndactor = UIActivityIndicatorView(style: .medium)
        activityIndactor.color = .gray
        activityIndactor.startAnimating()
        activityIndactor.hidesWhenStopped = true
        activityIndactor.center = view.center
        //activityIndactor.frame = CGRect(x: view.frame.height / 2, y: view.frame.width / 2, width: 10, height: 10)
        view.addSubview(activityIndactor)
        return activityIndactor
    }
    
    private func updateImage() {
        if let imageURL = imageURL {
            getImage(from: imageURL) { [weak self] result in
                switch result {
                case .success(let image):
                    if imageURL == self?.imageURL {
                        self?.coctailImageView.image = image
                        self?.activityIndicator?.stopAnimating()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        //cache
        if let cacheImage = ImageCacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
            completion(.success(cacheImage))
            return
        }
        
        //from URL
        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                completion(.success(image))
                ImageCacheManager.shared.setObject(image, forKey: url.lastPathComponent as NSString)
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
