//
//  Constants.swift
//  Food2Fork
//
//  Created by Natan Facchin on 07/02/17.
//  Copyright © 2017 NFS Industries. All rights reserved.
//

struct Constants {
    struct Defaults {
        //Add Default Constants here
        static let queryResults = 30
        static let recipeIdQuery = "&rId="
        static let ingredientsLabel = "Ingredients"
    }
    
    struct Segues {
        static let detailRecipe = "showDetail"
        static let completeRecipe = "completeRecipe"
    }
    
    struct NumValues {
        //Add Numerical Values here
    }
    
    struct Messages {
        //Add default messages here
    }
    
    struct URLS {
        static let searchURL = "http://food2fork.com/api/search?key=" + Constants.Keys.apiKey
        static let recipeURL = "http://food2fork.com/api/get?key=" + Constants.Keys.apiKey
        static let searchQuery = "&q="
    }
    
    struct JSONKeys {
        static let count = "count"
        static let recipes = "recipes"
        static let recipe = "recipe"
        static let publisher = "publisher"
        static let socialRank = "social_rank"
        static let f2fURL = "f2f_url"
        static let publisherURL = "publisher_url"
        static let sourceURL = "source_url"
        static let imageURL = "image_url"
        static let ingredients = "ingredients"
        static let page = "page"
        static let title = "title"
        static let recipeId = "recipe_id"
    }
    
    struct Keys {
        static let apiKey = "b549c4c96152e677eb90de4604ca61a2"
    }
}
