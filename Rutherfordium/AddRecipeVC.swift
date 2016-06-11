//
//  AddRecipeVC.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/20/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit
import CoreData

class AddRecipeVC: UIViewController, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate, UIScrollViewDelegate {
	
	// MARK: Properties
	@IBOutlet weak var categoryPicker: UIPickerView!
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var timeField: UITextField!
	@IBOutlet weak var servingsField: UITextField!
	@IBOutlet weak var linkField: UITextField!
	@IBOutlet weak var ingredientsField: UITextView!
	@IBOutlet weak var directionsField: UITextView!
	@IBOutlet weak var saveButton: UIButton!
	@IBOutlet weak var deleteButton: UIButton!
	@IBOutlet weak var mealPhoto: UIImageView!
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var stackView: UIStackView!
	
	var categories = [Category]()
	var recipeToEdit: Recipe?
	var keyboardMoveHeight: CGFloat = 0
	
	
	
	// MARK: Load / Appear Functions
	override func viewDidLoad() {
		super.viewDidLoad()
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddRecipeVC.keyboardWasShown(_:)), name: UIKeyboardDidShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddRecipeVC.keyboardWasHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)

		selfDelegates()
		configureImage()
		
		getCategories()
		
		if recipeToEdit != nil {
			loadRecipeData()
		}
	}
	
	override func viewDidAppear(animated: Bool) {
		configureScrollView()
	}
	
	
	
	// MARK: Core Data Fetch
	func getCategories() {
		let fetchRequest = NSFetchRequest(entityName: "Category")
		
		do {
			self.categories = try ad.managedObjectContext.executeFetchRequest(fetchRequest) as! [Category]
			categories = categories.sort({ $0.title < $1.title })
			self.categoryPicker.reloadAllComponents()
		} catch {
			print("\(error)")
		}
	}
	
	func loadRecipeData() {
		if let recipe = recipeToEdit {
			
			if let name = recipe.name {
				nameField.text = name
			}
			if let time = recipe.time {
				timeField.text = "\(time)"
			}
			if let servings = recipe.servings {
				servingsField.text = "\(servings)"
			}
			if let link = recipe.link {
				linkField.text = link
			}
			if let ingredients = recipe.ingredients {
				ingredientsField.text = ingredients
			}
			if let directions = recipe.directions {
				directionsField.text = directions
			}
			if let _ = recipe.photo {
				mealPhoto.image = recipe.getRecipeImage()
			}
			
			if let category = recipe.category {
				var index = 0
				repeat {
					let c = categories[index]
					if c.title == category.title {
						categoryPicker.selectRow(index, inComponent: 0, animated: true)
						break
					}
					index += 1
				} while (index < categories.count)
			}
		}
	}
	
	
	
	// MARK: Delegates / UI Components
	func selfDelegates() {
		nameField.delegate = self
		timeField.delegate = self
		servingsField.delegate = self
		linkField.delegate = self
		ingredientsField.delegate = self
		directionsField.delegate = self
		categoryPicker.delegate = self
		categoryPicker.dataSource = self
	}
	
	// UIImage
	func configureImage() {
		mealPhoto.clipsToBounds = true
	}
	
	// UIScrolLView
	func configureScrollView() {
		scrollView.contentSize.width = self.view.bounds.size.width
		scrollView.contentSize.height = stackView.bounds.size.height + 20
		scrollView.keyboardDismissMode = .Interactive
	}
	
	// UITextField
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	func textFieldDidBeginEditing(textField: UITextField) {
	}
	
	// UITextView
	func textViewDidEndEditing(textView: UITextView) {
		textView.resignFirstResponder()
	}
	
	// UIImagePickerControllerDelegate
	@IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
		
		let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
			// No action required
		}
		
		let libraryAction = UIAlertAction(title: "Pick from Library", style: .Default) { (action) in
			self.pickImageFromLibrary()
		}
		
		let takePhotoAction = UIAlertAction(title: "Take Photo", style: .Default) { (action) in
			self.takePhoto()
		}
		
		alertController.addAction(cancelAction)
		alertController.addAction(libraryAction)
		alertController.addAction(takePhotoAction)
		
		self.presentViewController(alertController, animated: true, completion: nil)
	}
	
	func takePhoto() {
		let imagePickerController = UIImagePickerController()
		imagePickerController.sourceType = .Camera
		imagePickerController.delegate = self
		
		presentViewController(imagePickerController, animated: true, completion: nil)
	}
	
	func pickImageFromLibrary() {
		let imagePickerController = UIImagePickerController()
		imagePickerController.sourceType = .PhotoLibrary
		imagePickerController.delegate = self
		
		presentViewController(imagePickerController, animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
		mealPhoto.image = selectedImage
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	// UIPickerView
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return categories.count
	}
	
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		let category = categories[row]
		return category.title
	}
	
	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		print(row)
	}
	
	// Keyboard Function
	func keyboardWasShown(notification: NSNotification) {
		var info = notification.userInfo!
		let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
		
		if directionsField.isFirstResponder() || linkField.isFirstResponder() {
			keyboardMoveHeight = keyboardFrame.size.height
		} else {
			keyboardMoveHeight = 0
		}
		
		if self.view.frame.origin.y == 0.0 {
			UIView.animateWithDuration(0.1, animations: { () -> Void in
				self.view.frame.origin.y -= self.keyboardMoveHeight
			})
		}
	}
	
	func keyboardWasHidden(notification: NSNotification) {
		if self.view.frame.origin.y != 0.0 {
			UIView.animateWithDuration(0.1, animations: { () -> Void in
				self.view.frame.origin.y = 0.0
			})
		}
	}
	
	
	
	// MARK: Save Button
	@IBAction func savePressed(sender: UIBarButtonItem) {
		var recipe: Recipe!
		
		if recipeToEdit == nil {
			recipe = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: ad.managedObjectContext) as! Recipe
		} else {
			recipe = recipeToEdit
		}
		
		if (nameField.text != "" && linkField.text != "") || (nameField.text != "" && (directionsField.text != "Directions" || directionsField.text != "")) {
			if let name = nameField.text {
				recipe.name = name
			}
			if let time = timeField.text {
				recipe.time = Double(time)
			}
			if let servings = servingsField.text {
				recipe.servings = Double(servings)
			}
			if let link = linkField.text {
				recipe.link = link
			}
			if let ingredients = ingredientsField.text {
				recipe.ingredients = ingredients
			}
			if let directions = directionsField.text {
				recipe.directions = directions
			}
			if let photo = mealPhoto.image {
				recipe.setRecipeImage(photo)
			}
			
			recipe.category = categories[categoryPicker.selectedRowInComponent(0)]
			
			ad.saveContext()
			self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
			self.navigationController?.popViewControllerAnimated(true)
		}
	}
	
	
	
	// MARK: NAVIGATION
	@IBAction func cancel(sender: UIBarButtonItem) {
		let isPresentedInAddMealMode = presentingViewController is UINavigationController
		
		if isPresentedInAddMealMode { // Modal, NavigationController
			dismissViewControllerAnimated(true, completion: nil)
		} else { // Show, Show details
			navigationController!.popViewControllerAnimated(true)
		}
	}
	

	
}


