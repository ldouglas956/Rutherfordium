//
//  Recipe.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/13/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import Foundation
import UIKit

class Recipe {
	
	var recipeName: String
	var recipeImage: UIImage
	
	init(name: String, image: UIImage) {
		self.recipeName = name
		self.recipeImage = image
	}
	
}
