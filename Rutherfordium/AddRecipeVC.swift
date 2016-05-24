//
//  AddRecipeVC.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/20/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit
import CoreData

class AddRecipeVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	
	@IBOutlet weak var categoryPicker: UIPickerView!
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var timeField: UITextField!
	@IBOutlet weak var servingsField: UITextField!
	@IBOutlet weak var linkField: UITextField!
	@IBOutlet weak var ingredientsField: UITextView!
	@IBOutlet weak var directionsField: UITextView!
	// Outlet for button background
	// Action for button imagePicker
	
	var categories = [Category]()
	var recipeToEdit: Recipe?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		categoryPicker.delegate = self
		categoryPicker.dataSource = self
		
		getCategories()
		if (categories.count == 0) {
			loadCategories()
			getCategories()
		}
		
		if recipeToEdit != nil {
			loadRecipeData()
		}
		
	}
	
	func loadRecipeData() {
		if let recipe = recipeToEdit {
			
			if let name = recipe.name {
				nameField.text = name
			}
			if let time = recipe.time {
				timeField.text = "\(time)"
			}
			if let servings = recipe.servings {
				servingsField.text = "\(servings)"
			}
			if let link = recipe.link {
				linkField.text = link
			}
			if let ingredients = recipe.ingredients {
				ingredientsField.text = ingredients
			}
			if let directions = recipe.directions {
				directionsField.text = directions
			}
			
			if let category = recipe.category {
				var index = 0
				repeat {
					let c = categories[index]
					if c.title == category.title {
						categoryPicker.selectRow(index, inComponent: 0, animated: true)
						break
					}
					index += 1
				} while (index < categories.count)
			}
		}
	}
	
	
	// MARK: CATEGORY PICKER CODE
	func loadCategories() {
//		let category1 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category2 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category3 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category4 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category5 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category6 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category7 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category8 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category9 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		
//		category1.title = "All"
		category2.title = "Breakfast"
		category3.title = "Dessert"
		category4.title = "Drinks"
		category5.title = "Main Course"
		category6.title = "Salad"
		category7.title = "Sides"
		category8.title = "Snacks"
		category9.title = "Soup / Chili"
			
		ad.saveContext()
	}
	
	func getCategories() {
		let fetchRequest = NSFetchRequest(entityName: "Category")
		
		do {
			self.categories = try ad.managedObjectContext.executeFetchRequest(fetchRequest) as! [Category]
			self.categoryPicker.reloadAllComponents()
		} catch {
			print("\(error)")
		}
	}

	
	// MARK: SAVE ITEM CODE
	@IBAction func savePressed(sender: UIBarButtonItem) {
		var recipe: Recipe!
		
		if recipeToEdit == nil {
			recipe = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		} else {
			recipe = recipeToEdit
		}
		
		if (nameField.text != "" && linkField.text != "") || (nameField.text != "" && (directionsField.text != "Directions" || directionsField.text != "")) {
			if let name = nameField.text {
				recipe.name = name
			}
			if let time = timeField.text {
				recipe.time = Double(time)
			}
			if let servings = servingsField.text {
				recipe.servings = Double(servings)
			}
			if let link = linkField.text {
				recipe.link = link
			}
			if let ingredients = ingredientsField.text {
				recipe.ingredients = ingredients
			}
			if let directions = directionsField.text {
				recipe.directions = directions
			}
			
			recipe.category = categories[categoryPicker.selectedRowInComponent(0)]
			
			ad.saveContext()
			self.navigationController?.popViewControllerAnimated(true)
		}
	}
	
	
	// MARK: DELETE ITEM CODE
	@IBAction func deletePressed(sender: UIButton) {
		if recipeToEdit != nil {
			areYouSureAlert()
		}
	}
	
	func areYouSureAlert() {
		let alertController = UIAlertController(title: "Delete?", message: "", preferredStyle: .Alert)
		
		let firstAction = UIAlertAction(title: "Keep It", style: UIAlertActionStyle.Default, handler: nil)
		let secondAction = UIAlertAction(title: "Delete It", style: UIAlertActionStyle.Destructive, handler: { action in
			self.deleteItem()
			self.navigationController?.popViewControllerAnimated(true) } )
		
		alertController.addAction(firstAction)
		alertController.addAction(secondAction)
		self.presentViewController(alertController, animated: true, completion: {})
	}
	
	func deleteItem() {
		ad.managedObjectContext.deleteObject(recipeToEdit!)
		ad.saveContext()
	}
	
	
	// MARK: PICKER VIEW BOILERPLATE
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return categories.count
	}
	
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		let category = categories[row]
		return category.title
	}
	
	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		print(row)
	}
	
}