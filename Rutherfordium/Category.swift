//
//  Category.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/13/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import Foundation
import UIKit

class Category {
	
	var catName: String
	var catImage: UIImage
	var catRecipeCount: Int
	
	init(name: String, image: UIImage, count: Int) {
		self.catName = name
		self.catImage = image
		self.catRecipeCount = count
		}
	
}
