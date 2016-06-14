//
//  SampleRecipes.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 6/7/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//
//  Template Recipes used from AllRecipes.com with links included to source website.
//

import UIKit
import CoreData

class SampleRecipes {
	
	// MARK: TEST DATA
	
//	category1.title = "7) Breakfast"
//	category2.title = "6) Dessert"
//	category3.title = "9) Drinks"
//	category4.title = "4) Main Course"
//	category5.title = "3) Salad"
//	category6.title = "5) Sides"
//	category7.title = "8) Snacks"
//	category8.title = "2) Soup / Chili"
//	category9.title = "1) Appetizers"
	
	func generateTestData(allCategories: [Category]) {
		let recipe0 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe0.name = "Guacamole"
		recipe0.setRecipeImage(UIImage(named: "guacamole")!)
		recipe0.category = allCategories[0]
		recipe0.servings = 4
		recipe0.time = 10
		recipe0.ingredients = "-3 Avocados\n-1 Lime\n-1 tsp Salt\n-1/2 Cup Diced Onion\n-3 tbsp Cilantro\n-2 Roma Tomatoes, diced\n-1 tsp Minced Garlic"
		recipe0.directions = "-In a medium bowl, mash together the avocados, lime juice, and salt.\n-Mix in onion, cilantro, tomatoes, and garlic. \n-Stir in cayenne pepper.\n- Refrigerate 1 hour for best flavor, or serve immediately."
		recipe0.link = "http://allrecipes.com/recipe/14231/guacamole/?internalSource=hub%20recipe&referringId=76&referringContentType=recipe%20hub"
		
		let recipe1 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe1.name = "Red, White, and Blue Flag Toast"
		recipe1.setRecipeImage(UIImage(named: "toast")!)
		recipe1.category = allCategories[6]
		recipe1.servings = 4
		recipe1.time = 10
		recipe1.ingredients = "-1 Cup Blueberries\n-4 Thick Slices Broche\n-1 4-oz Package Cream Cheese\n-4 Tsp Strawberry Jam\n-1 Sliced Banana"
		recipe1.directions = "-Toast slices of bread.  Spread each piece of toast with 2 tablespoons cream cheese.  Spread 1 teaspoon strawberry jam over the cream cheese except the upper left quarter.\n-Make 3 rows of 3 blueberries each in the upper left quarter, creating 'stars.' Make 3 rows of banana pieces, starting adjacent to the middle row of berries. Place the remaining 2 rows beneath the last row of berries, creating the 'stripes.'"
		recipe1.link = "http://allrecipes.com/recipe/242404/red-white-and-blue-flag-toast/?internalSource=rotd&referringId=78&referringContentType=recipe%20hub"
		
		let recipe2 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe2.name = "Dessert"
		recipe2.setRecipeImage(UIImage(named: "dessert")!)
		recipe2.category = allCategories[5]
		
		let recipe3 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe3.name = "Drinks"
		recipe3.setRecipeImage(UIImage(named: "drinks")!)
		recipe3.category = allCategories[8]
		
		let recipe4 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe4.name = "Main Course"
		recipe4.setRecipeImage(UIImage(named: "mainCourse")!)
		recipe4.category = allCategories[3]
		
		let recipe5 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe5.name = "Salad"
		recipe5.setRecipeImage(UIImage(named: "salad")!)
		recipe5.category = allCategories[2]
		
		let recipe6 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe6.name = "Sides"
		recipe6.setRecipeImage(UIImage(named: "sides")!)
		recipe6.category = allCategories[4]
		
		let recipe7 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe7.name = "Snacks"
		recipe7.setRecipeImage(UIImage(named: "snacks")!)
		recipe7.category = allCategories[7]
		
		let recipe8 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe8.name = "Soup"
		recipe8.setRecipeImage(UIImage(named: "soup")!)
		recipe8.category = allCategories[1]
		
		ad.saveContext()
	}
	
	
}
