//
//  FoodVC.swift
//  ChefPlate
//
//  Created by Shane Rosse on 5/5/16.
//  Copyright © 2016 Shane Rosse. All rights reserved.
//

import UIKit
import Firebase

class FoodVC: UIViewController {

    @IBOutlet weak var setMenu: UIButton!
    @IBOutlet weak var dinnerField: UITextField!
    @IBOutlet weak var sideOneField: UITextField!
    @IBOutlet weak var sideTwoField: UITextField!
    @IBOutlet weak var saladField: UITextField!
    @IBOutlet weak var extraField: UITextField!
    
    
    let db_base: String = "https://blazing-heat-9345.firebaseio.com"
    let db_menu: String = "prod/menu"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMenu.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func setMenuTouch(sender: AnyObject) {
        let myRootRef = Firebase(url: db_base)
        let myMenuRef = myRootRef.childByAppendingPath(db_menu)
        
        var menuData: [String] = []
        
        if let dinner = dinnerField.text {
            menuData.append(dinner)
        }
        
        if let sideOne = sideOneField.text {
            menuData.append(sideOne)
        }
        
        if let sideTwo = sideTwoField.text {
            menuData.append(sideTwo)
        }
        
        if let salad = saladField.text {
            menuData.append(salad)
        }
        
        if let extra = extraField.text {
            menuData.append(extra)
        }
        
        myMenuRef.setValue(menuData, withCompletionBlock: { (error, firebase) in
            var message: String = ""
            if (error != nil) {
                message = "Something went wrong in our database..."
                print("This is the Firebase error: \(error)")
            } else {
                message = "Thank you!"
            }
            let alertController = UIAlertController(title: "Late Plate", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Dismiss", style: .Default, handler: { (UIAlertAction) in
                self.dismissKeyboard()
            })
            
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: {
        
            })
        })


    }
    func dismissKeyboard() {
        dinnerField.resignFirstResponder()
        sideOneField.resignFirstResponder()
        sideTwoField.resignFirstResponder()
        saladField.resignFirstResponder()
        extraField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}