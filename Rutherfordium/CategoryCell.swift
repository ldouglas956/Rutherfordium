//
//  CategoryCell.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/13/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
	
	@IBOutlet weak var catTitle: UILabel!
	@IBOutlet weak var catCount: UILabel!
	@IBOutlet weak var catImage: UIImageView!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	

}
