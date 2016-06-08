//
//  RecipesVC.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/20/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit
import CoreData

class RecipesVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
	
	// MARK: Properties
	@IBOutlet weak var tableView: UITableView!
	
	var fetchedRecipeController: NSFetchedResultsController!
	var fetchedCategoryController: NSFetchedResultsController!
	
	var recipesOfCategory = [Recipe]()
	var allCategories = [Category]()
	var sampleRecipes = SampleRecipes()
	
	
	
	// MARK: Load / Appear Functions
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		deleteAllRecipes()
		
		attemptCategoryFetch()
		
		attemptRecipeFetch()
		if fetchedRecipeController.fetchedObjects?.count == 0 {
			sampleRecipes.generateTestData(allCategories)
//			generateTestData()
			attemptRecipeFetch()
		}
	}
	
	override func viewDidAppear(animated: Bool) {
		tableView.reloadData()
	}
	
	
	
	// MARK: Core Data Fetch
	func attemptRecipeFetch() {
		let fetchRecipeRequest = NSFetchRequest(entityName: "Recipe")
		let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
		fetchRecipeRequest.sortDescriptors = [sortDescriptor]
		
		let controller = NSFetchedResultsController(fetchRequest: fetchRecipeRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
//		controller.delegate = self
		fetchedRecipeController = controller
		
		do {
			try self.fetchedRecipeController.performFetch()
		} catch {
			let error = error as NSError
			print("\(error), \(error.userInfo)")
		}
	}
	
	func attemptCategoryFetch() {
		let fetchCategoryRequest = NSFetchRequest(entityName: "Category")
		let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
		fetchCategoryRequest.sortDescriptors = [sortDescriptor]
		
		let controller = NSFetchedResultsController(fetchRequest: fetchCategoryRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
//		controller.delegate = self
		fetchedCategoryController = controller
		
		do {
			try self.fetchedCategoryController.performFetch()
			allCategories = fetchedCategoryController.fetchedObjects as! [Category]
		} catch {
			let error = error as NSError
			print("\(error), \(error.userInfo)")
		}
	}

	
	
	// MARK: NSFetchedResultsController Code
	func controllerWillChangeContent(controller: NSFetchedResultsController) {
		tableView.beginUpdates()
	}
	
	func controllerDidChangeContent(controller: NSFetchedResultsController) {
		tableView.endUpdates()
	}
	
	func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
		
		switch(type) {
		case .Insert:
			if let indexPath = newIndexPath {
				tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
			}; break
		case .Delete:
			if let indexPath = indexPath {
				tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
			}; break
		case .Update:
			if let indexPath = indexPath {
				let cell = tableView.cellForRowAtIndexPath(indexPath) as! RecipeCell
				configureCell(cell, indexPath: indexPath)
			}; break
		case .Move:
			if let indexPath = indexPath {
				tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
			}
			if let newIndexPath = newIndexPath {
				tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
			}; break
		}
		
	}
	
	
	
	// MARK: UITableView Code
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		if let sections = fetchedRecipeController.sections {
			return sections.count
		}
		return 0
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let sections = fetchedRecipeController.sections {
			let sectionInfo = sections[section]
			return sectionInfo.numberOfObjects
		}
		return 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath) as! RecipeCell
		configureCell(cell, indexPath: indexPath)
		
		return cell
	}
	
	func configureCell(cell: RecipeCell, indexPath: NSIndexPath) {
		if let recipe = fetchedRecipeController.objectAtIndexPath(indexPath) as? Recipe {
			cell.configureCell(recipe)
		}
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
		if let objs = fetchedRecipeController.fetchedObjects where objs.count > 0 {
			let item = objs[indexPath.row] as! Recipe
			
			performSegueWithIdentifier("EditRecipe", sender: item)
		}
	}
	
	
	
	// MARK: NAVIGATION
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "EditRecipe" {
			print("Viewing / Editing Recipe")
			let vc = segue.destinationViewController as! AddRecipeVC
			vc.recipeToEdit = sender as? Recipe
		} else if segue.identifier == "AddRecipe" {
			print("Adding new Recipe from RecipesVC")
		}
	}
	
	
	
	// MARK: Additional Functions
	func deleteAllRecipes() {
		let context = ad.managedObjectContext
		let coord = ad.persistentStoreCoordinator
		
		let fetchRequest = NSFetchRequest(entityName: "Recipe")
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
		
		do {
			try coord.executeRequest(deleteRequest, withContext: context)
		} catch let error as NSError {
			debugPrint(error)
		}
	}

}


