//
//  NetworkManager.swift
//  Drinks
//
//  Created by igor s on 12.08.2022.
//

import Foundation

enum Link: String {
    case negroniURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=negroni"
    case margaritaURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"
    case cosmopolitanURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=cosmopolitan"
    case ginURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=gin"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T:Decodable>(_ type: T.Type, from url: String?, completion: @escaping(Result<T, NetworkError>) -> Void ) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
