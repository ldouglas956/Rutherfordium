//
//  CategoryVC.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/20/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit
import CoreData

class CategoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
	
	@IBOutlet weak var tableView: UITableView!
	
	var fetchedResultsController: NSFetchedResultsController!
	var categories = [Category]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		fetchCategories()
		if fetchedResultsController.fetchedObjects?.count == 0 {
			initializeCategories()
			fetchCategories()
		}
    }

	
	// MARK: Load Category Data
	func fetchCategories() {
		let fetchRequest = NSFetchRequest(entityName: "Category")
		let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		
		let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
		controller.delegate = self
		fetchedResultsController = controller
		
		do {
			try self.fetchedResultsController.performFetch()
		} catch {
			let error = error as NSError
			print("\(error), \(error.userInfo)")
		}
	}

	
	func initializeCategories() {
		let category1 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category2 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category3 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category4 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category5 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category6 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category7 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category8 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		
		category1.title = "Breakfast"
		category2.title = "Dessert"
		category3.title = "Drinks"
		category4.title = "Main Course"
		category5.title = "Salad"
		category6.title = "Sides"
		category7.title = "Snacks"
		category8.title = "Soup / Chili"
		
		category1.setCatImage(UIImage(named: "breakfast")!)
		category2.setCatImage(UIImage(named: "dessert")!)
		category3.setCatImage(UIImage(named: "drinks")!)
		category4.setCatImage(UIImage(named: "mainCourse")!)
		category5.setCatImage(UIImage(named: "salad")!)
		category6.setCatImage(UIImage(named: "sides")!)
		category7.setCatImage(UIImage(named: "snacks")!)
		category8.setCatImage(UIImage(named: "soup")!)
		
		ad.saveContext()
	}
	
	
	// MARK: TableView Code
//	func configureCell(cell: CategoryCell, indexPath: NSIndexPath) {
//		if let category = fetchedResultsController.objectAtIndexPath(indexPath) as? Category {
//			cell.configureCell(category)
//		}
//	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 8
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCell
		if let category = fetchedResultsController.objectAtIndexPath(indexPath) as? Category {
			cell.configureCell(category)
		}

		return CategoryCell()
	}


//	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//
//		if let objs = fetchedResultsController.fetchedObjects where objs.count > 0 {
//			let item = objs[indexPath.row] as! Category
//
//			performSegueWithIdentifier("ListRecipes", sender: item)
//		}
//	}
	
	
	// MARK: NAVIGATION
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "ListRecipes" {
			print("Viewing List of Recipes")
//			let vc = segue.destinationViewController as! RecipesVC
			
			// Information to send is an array of Recipes with a given category
			
			
		} else if segue.identifier == "AddRecipe" {
			print("Adding new Recipe from CategoryVC")
		} else if segue.identifier == "ShowRecipesVC" {
			print("Showing RecipesVC with Shortcut")
		}
	}
	
	
	// MARK: ORIGINAL CODE
	
//	func loadCategories() {
//		let breakfast = Category(name: "Breakfast", image: UIImage(named: "breakfast")!, count: 0)
//		let dessert = Category(name: "Dessert", image: UIImage(named: "dessert")!, count: 0)
//		let mainCourse = Category(name: "Main Course", image: UIImage(named: "mainCourse")!, count: 0)
//		let salad = Category(name: "Salad", image: UIImage(named: "salad")!, count: 0)
//		let sides = Category(name: "Sides", image: UIImage(named: "sides")!, count: 0)
//		let snacks = Category(name: "Snacks", image: UIImage(named: "snacks")!, count: 0)
//		let soupChili = Category(name: "Soup / Chili", image: UIImage(named: "soup")!, count: 0)
//		
//		categories += [breakfast, dessert, mainCourse, salad, sides, snacks, soupChili]
//	}
//	
//	
//	// TABLE VIEW BOILERPLATE CODE
//	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//		return 1
//	}
//	
//	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		print(categories.count)
//		return categories.count
//	}
//	
//	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//		
//		let cellIdentifier = "CategoryCell"
//		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CategoryCell
//		
//		let category = categories[indexPath.row]
//		
//		cell.catTitle.text = category.catName
//		cell.catImage.image = category.catImage
//		cell.catCount.text = String(category.catRecipeCount) + " Recipes"
//		
//		return cell
//	}
	
}
