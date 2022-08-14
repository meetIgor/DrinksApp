//
//  Drink.swift
//  Drinks
//
//  Created by igor s on 12.08.2022.
//

import Foundation

struct Drink: Decodable {
    let drinks: [Coctail]
    
    var description: String {
        var result = ""
        for drink in drinks {
            result += "\n" + drink.description + "\n"
        }
        return result
    }
}

struct Coctail: Decodable {
    let drink: String
    let category: String
    let glass: String
    let instructions: String
    let drinkThumb: String
    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?
    let ingredient6: String?
    let ingredient7: String?
    let ingredient8: String?
    let ingredient9: String?
    let ingredient10: String?
    let ingredient11: String?
    let ingredient12: String?
    let ingredient13: String?
    let ingredient14: String?
    let ingredient15: String?
    let measure1: String?
    let measure2: String?
    let measure3: String?
    let measure4: String?
    let measure5: String?
    let measure6: String?
    let measure7: String?
    let measure8: String?
    let measure9: String?
    let measure10: String?
    let measure11: String?
    let measure12: String?
    let measure13: String?
    let measure14: String?
    let measure15: String?
    
    var description: String {
        """
        Title: \(drink)
        Category: \(category)
        Glass Type: \(glass)
        Recipe: \(instructions)
        Image: \(drinkThumb)
        Ingredients: \(ingredients.map {$0}.joined(separator: ", ") )
        """
    }
}

//Coding Keys
extension Coctail {
    enum CodingKeys: String, CodingKey {
        case drink = "strDrink"
        case category = "strCategory"
        case glass = "strGlass"
        case instructions = "strInstructions"
        case drinkThumb = "strDrinkThumb"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
    }
}

//Arrays from ingredients and measures
extension Coctail {
    
    var measures: [String] {
        var result: [String] = []
        
        guard let measure = measure1 else { return result}
        result.append(measure)
        guard let measure = measure2 else { return result}
        result.append(measure)
        guard let measure = measure3 else { return result}
        result.append(measure)
        guard let measure = measure4 else { return result}
        result.append(measure)
        guard let measure = measure5 else { return result}
        result.append(measure)
        guard let measure = measure6 else { return result}
        result.append(measure)
        guard let measure = measure7 else { return result}
        result.append(measure)
        guard let measure = measure8 else { return result}
        result.append(measure)
        guard let measure = measure9 else { return result}
        result.append(measure)
        guard let measure = measure10 else { return result}
        result.append(measure)
        guard let measure = measure11 else { return result}
        result.append(measure)
        guard let measure = measure12 else { return result}
        result.append(measure)
        guard let measure = measure13 else { return result}
        result.append(measure)
        guard let measure = measure14 else { return result}
        result.append(measure)
        guard let measure = measure15 else { return result}
        result.append(measure)
        
        return result
    }
    
    var ingredients: [String] {
        var result: [String] = []
        
        guard let ingredient = ingredient1 else { return result}
        result.append(ingredient)
        guard let ingredient = ingredient2 else { return result}
        result.append(ingredient)
        guard let ingredient = ingredient3 else { return result}
        result.append(ingredient)
        guard let ingredient = ingredient4 else { return result}
        result.append(ingredient)
        guard let ingredient = ingredient5 else { return result}
        result.append(ingredient)
        guard let ingredient = ingredient6 else { return result}
        result.append(ingredient)
        guard let ingredient = ingredient7 else { return result}
        result.append(ingredient)
        guard let ingredient = ingredient8 else { return result}
        result.append(ingredient)
        guard let ingredient = ingredient9 else { return result}
        result.append(ingredient)
        guard let ingredient = ingredient10 else { return result}
        result.append(ingredient)
        guard let ingredient = ingredient11 else { return result}
        result.append(ingredient)
        guard let ingredient = ingredient12 else { return result}
        result.append(ingredient)
        guard let ingredient = ingredient13 else { return result}
        result.append(ingredient)
        guard let ingredient = ingredient14 else { return result}
        result.append(ingredient)
        guard let ingredient = ingredient15 else { return result}
        result.append(ingredient)
        
        return result
    }
}

enum DrinkTypes: String, CaseIterable {
    case negroni = "negroni"
    case margarita = "margarita"
    case cosmopolitan = "cosmopolitan"
    case daiquiri = "daiquiri"
    case gin = "gin"
}
