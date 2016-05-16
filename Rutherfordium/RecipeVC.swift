//
//  RecipeVC.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/16/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit

class RecipeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

	
	@IBOutlet weak var tableView: UITableView!
	var recipes = [Recipe]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		
		loadTestRecipe()
    }

	
	func loadTestRecipe() {
		
		let sandwich = Recipe(name: "My Sandwich", image: UIImage(named: "snacks")!)
		
		recipes += [sandwich]
	}

	// TABLE VIEW BOILERPLATE CODE
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return recipes.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cellIdentifier = "RecipeCell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RecipeCell
		
		let recipe = recipes[indexPath.row]
		cell.recipeTitle.text = recipe.recipeName
		cell.recipeImage.image = recipe.recipeImage
		
		return cell
	}

}
