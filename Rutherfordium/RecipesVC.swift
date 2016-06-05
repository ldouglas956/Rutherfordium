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
	
	@IBOutlet weak var tableView: UITableView!
	
	var fetchedResultsController: NSFetchedResultsController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		attemptFetch()
	}
	
	override func viewDidAppear(animated: Bool) {
		tableView.reloadData()
	}
	
	// MARK: CORE DATA BOILERPLATE CODE
	func attemptFetch() {
		setFetchedResults()
		
		do {
			try self.fetchedResultsController.performFetch()
		} catch {
			let error = error as NSError
			print("\(error), \(error.userInfo)")
		}
	}
	
	func setFetchedResults() {
//		let section: String? = segment.selectedSegmentIndex == 1 ? "category.title" : nil // from generated Item and Store relationship
		let fetchRequest = NSFetchRequest(entityName: "Recipe")
		let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		
		let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
		controller.delegate = self
		fetchedResultsController = controller
	}
	
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
	
	
	// MARK: TABLE VIEW BOILERPLATE CODE
	func configureCell(cell: RecipeCell, indexPath: NSIndexPath) {
		if let recipe = fetchedResultsController.objectAtIndexPath(indexPath) as? Recipe {
			cell.configureCell(recipe)
		}
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		if let sections = fetchedResultsController.sections {
			return sections.count
		}
		return 0
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let sections = fetchedResultsController.sections {
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
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
		if let objs = fetchedResultsController.fetchedObjects where objs.count > 0 {
			let item = objs[indexPath.row] as! Recipe
			
			performSegueWithIdentifier("EditRecipe", sender: item)
		}
	}
	
//	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//		
//		if let objs = fetchedResultsController.fetchedObjects where objs.count > 0 {
//			let item = objs[indexPath.row] as! Recipe
//			
//			let vc = AddRecipeVC()
//			vc.recipeToEdit = item
//			
//			navigationController?.pushViewController(vc, animated: true)
//			
////			performSegueWithIdentifier("EditRecipe", sender: item)
//		}
//	}
	
	
	// MARK: NAVIGATION
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "EditRecipe" {
			print("Viewing / Editing Recipe")
			let vc = segue.destinationViewController as! AddRecipeVC
			vc.recipeToEdit = sender as? Recipe
		} else if segue.identifier == "AddRecipe" {
			print("Adding new Recipe")
		}
		
//		let backItem = UIBarButtonItem()
//		backItem.title = "Cancel"
//		navigationItem.backBarButtonItem = backItem
	}
	
	
	// MARK: TEST DATA
	func generateTestData() {
		let recipe1 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe1.name = "Bacon and Eggs"
		
		let recipe2 = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		recipe2.name = "Chicken Pot Pie"
		
		ad.saveContext()
	}
	

}

