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
	
	// MARK: Properties
	@IBOutlet weak var tableView: UITableView!
	
	var fetchedResultsController: NSFetchedResultsController!
	var categories = Categories()
	var allCategories = [Category]()
	var sampleRecipes = SampleRecipes()
	
	var categorySelectionIndex: Int?
	
	
	// MARK: Load / Appear Functions
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		fetchCategories()
		if fetchedResultsController.fetchedObjects?.count == 0 {
			categories.initializeCategories()
			fetchCategories()
			sampleRecipes.generateTestData(allCategories)
		}
    }
	
	override func viewDidAppear(animated: Bool) {
		tableView.reloadData()
	}
	
	
	
	// MARK: Core Data Fetch
	func fetchCategories() {
		let fetchRequest = NSFetchRequest(entityName: "Category")
		let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		
		let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
		fetchedResultsController = controller
		
		do {
			try self.fetchedResultsController.performFetch()
			allCategories = fetchedResultsController.fetchedObjects as! [Category]
		} catch {
			let error = error as NSError
			print("\(error), \(error.userInfo)")
		}
	}
	
	
	
	// MARK: TableView Code
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 9
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCell
		if let category = fetchedResultsController.objectAtIndexPath(indexPath) as? Category {
			cell.configureCell(category)
		}

		return CategoryCell()
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		if let objs = fetchedResultsController.fetchedObjects where objs.count > 0 {
			let item = objs[indexPath.row] as! Category
			categorySelectionIndex = indexPath.row

			performSegueWithIdentifier("ListRecipes", sender: item)
		}
	}
	
	
	
	// MARK: NAVIGATION
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "ListRecipes" {
			print("Viewing List of Recipes")
			let vc = segue.destinationViewController as! RecipesVC
			vc.index = categorySelectionIndex
		} else if segue.identifier == "AddRecipe" {
			print("Adding new Recipe from CategoryVC")
		}
	}
	
}


