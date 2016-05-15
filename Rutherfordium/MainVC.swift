//
//  ViewController.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/13/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var tableView: UITableView!
	var categories = [Category]()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self

		loadCategories()
	}

	
	func loadCategories() {
		let breakfast = Category(name: "Breakfast", image: UIImage(named: "breakfast")!, count: 0)
		let dessert = Category(name: "Dessert", image: UIImage(named: "dessert")!, count: 0)
		let mainCourse = Category(name: "Main Course", image: UIImage(named: "mainCourse")!, count: 0)
		let salad = Category(name: "Salad", image: UIImage(named: "salad")!, count: 0)
		let sides = Category(name: "Sides", image: UIImage(named: "sides")!, count: 0)
		let snacks = Category(name: "Snacks", image: UIImage(named: "snacks")!, count: 0)
		let soupChili = Category(name: "Soup / Chili", image: UIImage(named: "soup")!, count: 0)
		
		categories += [breakfast, dessert, mainCourse, salad, sides, snacks, soupChili]
	}
	
	
	// TABLE VIEW BOILERPLATE CODE
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print(categories.count)
		return categories.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cellIdentifier = "CategoryCell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CategoryCell
		
		let category = categories[indexPath.row]
		
		cell.catTitle.text = category.catName
		cell.catImage.image = category.catImage
		cell.catCount.text = String(category.catRecipeCount) + " Recipes"
		
		return cell
	}
	
	
	
	
}

