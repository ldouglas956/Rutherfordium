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
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
    }
	
	// MARK: TABLE VIEW BOILERPLATE CODE
//	func configureCell(cell: CategoryCell, indexPath: NSIndexPath) {
//		if let recipe = fetchedResultsController.objectAtIndexPath(indexPath) as? Category {
//			cell.configureCell(category)
//		}
//	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//		if let sections = fetchedResultsController.sections {
//			return sections.count
//		}
		return 0
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		if let sections = fetchedResultsController.sections {
//			let sectionInfo = sections[section]
//			return sectionInfo.numberOfObjects
//		}
		return 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//		let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath) as! RecipeCell
//		configureCell(cell, indexPath: indexPath)
//		
//		return cell
		return CategoryCell()
	}
	
}
