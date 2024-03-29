//
//  MealsData.swift
//  FetchiOSMeals
//
//  Created by user on 3/28/24.
//

import Foundation
import SwiftUI

struct MealList: Decodable {
    var meals: [Meal]
}

struct Meal: Decodable {
    var idMeal: String
    var strMeal: String
    var strMealThumb: String
}

struct MealDetail: Decodable {
    var meals: [MealInfo]
}

struct MealInfo: Decodable {
    var strMeal: String
    var strInstructions: String
    var strMealThumb: String
    var ingredients: [String: String] = [:]

    private enum CodingKeys: String, CodingKey {
        case strMeal, strInstructions, strMealThumb
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        
        // Decode ingredients and measurements
        let additionalContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        for i in 1...20 {
            let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)")!
            let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(i)")!
            if let ingredient = try additionalContainer.decodeIfPresent(String.self, forKey: ingredientKey),
               !ingredient.isEmpty,
               let measure = try additionalContainer.decodeIfPresent(String.self, forKey: measureKey),
               !measure.isEmpty {
                ingredients[ingredient] = measure
            }
        }
    }

    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = "\(intValue)"
        }
    }
}

