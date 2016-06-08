//
//  SampleRecipes.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 6/7/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit
import CoreData

class SampleRecipes {
	
	// MARK: TEST DATA
	
	//	category1.title = "Breakfast"
	//	category2.title = "Dessert"
	//	category3.title = "Drinks"
	//	category4.title = "Main Course"
	//	category5.title = "Salad"
	//	category6.title = "Sides"
	//	category7.title = "Snacks"
	//	category8.title = "Soup / Chili"
	
	func generateTestData(allCategories: [Category]) {
		let recipe0 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe0.name = "Bacon and Eggs"
		recipe0.setRecipeImage(UIImage(named: "bacon")!)
		recipe0.category = allCategories[0]
		
		let recipe1 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe1.name = "Chocolate Heart Cookies"
		recipe1.setRecipeImage(UIImage(named: "cookie")!)
		recipe1.category = allCategories[1]
		
		let recipe2 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe2.name = "Third Sample"
		recipe2.setRecipeImage(UIImage(named: "cookie")!)
		recipe2.category = allCategories[2]
		
		let recipe3 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe3.name = "Fourth Sample"
		recipe3.setRecipeImage(UIImage(named: "cookie")!)
		recipe3.category = allCategories[3]
		
		let recipe4 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe4.name = "Fifth Sample"
		recipe4.setRecipeImage(UIImage(named: "cookie")!)
		recipe4.category = allCategories[4]
		
		let recipe5 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe5.name = "Sixth Entry"
		recipe5.setRecipeImage(UIImage(named: "cookie")!)
		recipe5.category = allCategories[5]
		
		let recipe6 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe6.name = "Seventh Entry"
		recipe6.setRecipeImage(UIImage(named: "cookie")!)
		recipe6.category = allCategories[6]
		
		let recipe7 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe7.name = "Eighth Entry"
		recipe7.setRecipeImage(UIImage(named: "cookie")!)
		recipe7.category = allCategories[7]
		
		ad.saveContext()
	}
	
	
}
