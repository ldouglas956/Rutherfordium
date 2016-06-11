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
		recipe0.name = "Appetizer"
		recipe0.setRecipeImage(UIImage(named: "appetizers")!)
		recipe0.category = allCategories[0]
		
		let recipe1 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe1.name = "Breakfast"
		recipe1.setRecipeImage(UIImage(named: "breakfast")!)
		recipe1.category = allCategories[6]
		
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
