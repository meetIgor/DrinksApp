//
//  NetworkManager.swift
//  Drinks
//
//  Created by igor s on 12.08.2022.
//

import Foundation
import Alamofire

enum Link: String {
    case drinkURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
    case ingredientImageURL = "https://www.thecocktaildb.com/images/ingredients/"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchDrinks(from url: String, completion: @escaping(Result<Drink, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let drinks = Drink.getDrinks(value: value)
                    completion(.success(drinks))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataRequest in
                switch dataRequest.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: URL, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataRequest in
                switch dataRequest.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
