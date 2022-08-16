//
//  Drink.swift
//  Drinks
//
//  Created by igor s on 12.08.2022.
//

import Foundation

struct Drink: Decodable {
    let drinks: [Сocktail]
    
    var description: String {
        var result = ""
        for drink in drinks {
            result += "\n" + drink.description + "\n"
        }
        return result
    }
    
    static func getDrinks(value: Any) -> Drink {
        guard let drink = value as? [String: Any] else { return Drink(drinks: []) }
        guard let cocktails = drink["drinks"] as? [[String: Any]] else { return Drink(drinks: []) }
        return Drink(drinks: cocktails.compactMap { Сocktail(cocktailsData: $0) } )
    }
}

struct Сocktail: Decodable {
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
    
    init(cocktailsData: [String: Any]) {
        drink = cocktailsData["strDrink"] as? String ?? ""
        category = cocktailsData["strCategory"] as? String ?? ""
        glass = cocktailsData["strGlass"] as? String ?? ""
        instructions = cocktailsData["strInstructions"] as? String ?? ""
        drinkThumb = cocktailsData["strDrinkThumb"] as? String ?? ""
        ingredient1 = cocktailsData["strIngredient1"] as? String
        ingredient2 = cocktailsData["strIngredient2"] as? String
        ingredient3 = cocktailsData["strIngredient3"] as? String
        ingredient4 = cocktailsData["strIngredient4"] as? String
        ingredient5 = cocktailsData["strIngredient5"] as? String
        ingredient6 = cocktailsData["strIngredient6"] as? String
        ingredient7 = cocktailsData["strIngredient7"] as? String
        ingredient8 = cocktailsData["strIngredient8"] as? String
        ingredient9 = cocktailsData["strIngredient9"] as? String
        ingredient10 = cocktailsData["strIngredient10"] as? String
        ingredient11 = cocktailsData["strIngredient11"] as? String
        ingredient12 = cocktailsData["strIngredient12"] as? String
        ingredient13 = cocktailsData["strIngredient13"] as? String
        ingredient14 = cocktailsData["strIngredient14"] as? String
        ingredient15 = cocktailsData["strIngredient15"] as? String
        measure1 = cocktailsData["strMeasure1"] as? String
        measure2 = cocktailsData["strMeasure2"] as? String
        measure3 = cocktailsData["strMeasure3"] as? String
        measure4 = cocktailsData["strMeasure4"] as? String
        measure5 = cocktailsData["strMeasure5"] as? String
        measure6 = cocktailsData["strMeasure6"] as? String
        measure7 = cocktailsData["strMeasure7"] as? String
        measure8 = cocktailsData["strMeasure8"] as? String
        measure9 = cocktailsData["strMeasure9"] as? String
        measure10 = cocktailsData["strMeasure10"] as? String
        measure11 = cocktailsData["strMeasure11"] as? String
        measure12 = cocktailsData["strMeasure12"] as? String
        measure13 = cocktailsData["strMeasure13"] as? String
        measure14 = cocktailsData["strMeasure14"] as? String
        measure15 = cocktailsData["strMeasure15"] as? String
    }
    
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

//Arrays from ingredients and measures
extension Сocktail {
    var ingredients: [String] {
        return [
            ingredient1, ingredient2, ingredient3, ingredient4, ingredient5, ingredient6,
            ingredient7, ingredient8, ingredient9, ingredient10, ingredient11, ingredient12,
            ingredient13, ingredient14, ingredient15
        ].compactMap { $0 }
    }
    
    var measures: [String] {
        var allMeasures = [
            measure1, measure2, measure3, measure4, measure5, measure6, measure7, measure8,
            measure9, measure10, measure11, measure12, measure13, measure14, measure15
        ].compactMap { $0 ?? ""}
        allMeasures.removeLast(allMeasures.count - ingredients.count)
        
        return allMeasures
    }
}

enum DrinkTypes: String, CaseIterable {
    case negroni = "negroni"
    case margarita = "margarita"
    case cosmopolitan = "cosmopolitan"
    case daiquiri = "daiquiri"
    case gin = "gin"
}
