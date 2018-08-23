//
//  Recipe.swift
//  Food2Fork
//
//  Created by Natan Facchin on 07/02/17.
//  Copyright © 2017 NFS Industries. All rights reserved.
//

import Foundation

class Recipe {
    var title: String = ""
    var photoURL: String = ""
    var sourceURL: String?
    var publisher: String?
    var publisherURL: String?
    var ingredients = [String]()
    var f2fUrl: String = ""
    var recipeId: String = ""
    var socialRank: Double = 0.0
    
    init(jsonWithDetailedRecipe: Any) {
        if let jsonDict = jsonWithDetailedRecipe as? [String: Any] {
            if let dictionary = jsonDict[Constants.JSONKeys.recipe] as? [String: Any] {
                
                if let aTitle = dictionary[Constants.JSONKeys.title] as? String {
                    title = aTitle
                }
                if let aF2fURL = dictionary[Constants.JSONKeys.f2fURL] as? String {
                    f2fUrl = aF2fURL
                }
                if let aSocialRank = dictionary[Constants.JSONKeys.socialRank] as? Double {
                    socialRank = aSocialRank
                }
                if let aSourceURL = dictionary[Constants.JSONKeys.sourceURL] as? String {
                    sourceURL = aSourceURL
                }
                if let aPublisherURL = dictionary[Constants.JSONKeys.publisherURL] as? String {
                    publisherURL = aPublisherURL
                }
                if let aPublisher = dictionary[Constants.JSONKeys.publisher] as? String {
                    publisher = aPublisher
                }
                
                if let theIngredientsJSONArray = dictionary[Constants.JSONKeys.ingredients] as? [String] {
                    for currentIngredient in theIngredientsJSONArray {
                        ingredients.append(currentIngredient)
                    }
                    
                }
                if let anImageURL = dictionary[Constants.JSONKeys.imageURL] as? String {
                    photoURL = anImageURL
                }
                if let anId = dictionary[Constants.JSONKeys.recipeId] as? String {
                    recipeId = anId
                }
            }
        }
    }
    
    init(jsonWithObjectRoot: Any) {
        if let dictionary = jsonWithObjectRoot as? [String: Any] {
            if let aTitle = dictionary[Constants.JSONKeys.title] as? String {
                title = aTitle
            }
            if let aF2fURL = dictionary[Constants.JSONKeys.f2fURL] as? String {
                f2fUrl = aF2fURL
            }
            if let aSocialRank = dictionary[Constants.JSONKeys.socialRank] as? Double {
                socialRank = aSocialRank
            }
            if let aSourceURL = dictionary[Constants.JSONKeys.sourceURL] as? String {
                sourceURL = aSourceURL
            }
            if let aPublisherURL = dictionary[Constants.JSONKeys.publisherURL] as? String {
                publisherURL = aPublisherURL
            }
            if let aPublisher = dictionary[Constants.JSONKeys.publisher] as? String {
                publisher = aPublisher
            }
            if (dictionary[Constants.JSONKeys.ingredients] as? [String]) != nil {
                for currentIngredient in ingredients {
                    ingredients.append(currentIngredient)
                }
            }
            if let anImageURL = dictionary[Constants.JSONKeys.imageURL] as? String {
                photoURL = anImageURL
            }
            if let anId = dictionary[Constants.JSONKeys.recipeId] as? String {
                recipeId = anId
            }
        }
    }
}

func getRecipeArrayFromQuery(jsonWithObjectRoot: Any) -> [Recipe] {
    var recipeArray = [Recipe]()
    if let dictionary = jsonWithObjectRoot as? [String: Any] {
        if let recipeJSONArray = dictionary[Constants.JSONKeys.recipes] as? [Any] {
            for currentRecipeJSON in recipeJSONArray {
                // access all recipe objects in array
                let aRecipe = Recipe(jsonWithObjectRoot: currentRecipeJSON)
                recipeArray.append(aRecipe)
            }
        }
    }
    return recipeArray
}
