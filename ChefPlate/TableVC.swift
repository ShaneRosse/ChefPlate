//
//  TableVC.swift
//  ChefPlate
//
//  Created by Shane Rosse on 4/9/16.
//  Copyright © 2016 Shane Rosse. All rights reserved.
//

import UIKit
import Firebase

class TableVC: UITableViewController {
    
    var names: [String] = []
    var refreshCon: UIRefreshControl!
    
    let db_url: String = "https://blazing-heat-9345.firebaseio.com/prod/users"
    
    var snap: String?
    var people: Dictionary<String, AnyObject>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startUp()
        self.refreshCon = UIRefreshControl()
        self.refreshCon.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshCon.addTarget(self, action: #selector(refreshTouch), forControlEvents: .ValueChanged)
        self.tableView.addSubview(self.refreshCon)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshTable() {
        names = self.getNames()
        self.tableView.reloadData()
    }
    
    func refreshTouch(sender: AnyObject) {
        refreshTable()
        self.refreshCon.endRefreshing()
    }
    @IBAction func clearTouch(sender: AnyObject) {
        let confirm: UIAlertController = UIAlertController(title: "Pi Kappa Phi", message: "Are you sure you wish to erase?", preferredStyle: .ActionSheet)
        let positive: UIAlertAction = UIAlertAction(title: "YES", style: .Default, handler: { (UIAlertAction) in
            self.cleanUp()
            self.thankYou()
        })
        let negative: UIAlertAction = UIAlertAction(title: "NO", style: .Default) { (UIAlertAction) in
            //
        }
        confirm.addAction(positive)
        confirm.addAction(negative)
        self.presentViewController(confirm, animated: true) {
            
        }

    }
    
    func thankYou() {
        let alert: UIAlertController = UIAlertController(title: "Pi Kappa Phi", message: "Thank you!", preferredStyle: .Alert)
        let action: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) in
            self.refreshTable()
        })
        alert.addAction(action)
        self.presentViewController(alert, animated: true) {
        }
    }
    
    func startUp() {
        let ref = Firebase(url: db_url)
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            if (snapshot.value == nil) {
                print("No value from Firebase")
            } else {
                self.people = snapshot.value as? Dictionary
                self.refreshTable()
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    
    func count() -> Int {
        if let data = people {
            return data.count
        } else {
            return 0
        }
    }
    
    func getNames() -> [String] {
        var result: [String] = []
        if let people = people {
            for (key, object) in people {
                print("Garbage timestamp: \(key)")
                if (!result.contains(object as! String)) {
                    result.append(object as! String)
                }
            }
        }
        return result
    }
    
    func cleanUp() {
        let ref = Firebase(url: db_url)
        ref.removeValue()
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reusePlate", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = names[indexPath.row]
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Late Plate"
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    //    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let label: UILabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, 70))
    //        label.text = "Late Plates"
    //        label.textAlignment = UI
    //        let header: UIView = UIView(frame: tableView.accessibilityFrame)
    //        header.addSubview(label)
    //        return header
    //    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
        names.removeAtIndex(indexPath.row)
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
