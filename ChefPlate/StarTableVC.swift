//
//  StarTableVC.swift
//  ChefPlate
//
//  Created by Shane Rosse on 5/4/16.
//  Copyright © 2016 Shane Rosse. All rights reserved.
//

import UIKit
import Firebase


class StarTableVC: UITableViewController {

    let feedback_db: String = "https://blazing-heat-9345.firebaseio.com/prod/feedback"
    var date_db: String?
    
    var reviews: Dictionary<String, [String]>?
    var orderedReviews: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startUp()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func startUp() {
        let ref = Firebase(url: date_db)
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            if (snapshot.value == nil) {
                print("No value from Firebase")
            } else {
                self.reviews = snapshot.value as? Dictionary
                self.orderedReviews = self.dictToList(self.reviews!)
                self.tableView.reloadData()
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    func dictToList(input: Dictionary<String, [String]>) -> [String] {
        var result: [String] = []
        if let reviews = reviews {
            for (key, object) in reviews {
                print("datetime: \(key)")
                let content = "\(object[1])^\(object[2])^\(object[0]) "
                result.append(content)
            }
        }
        return result.sort()
    }
    
    func giveDayNumber(input: String) {
        date_db = feedback_db + "/" + input
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderedReviews.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseStar", forIndexPath: indexPath)

        // Configure the cell...
        let parts: [String] = orderedReviews[indexPath.row].componentsSeparatedByString("^")
        cell.detailTextLabel?.text = parts[2]
        cell.textLabel?.text = "\(parts[0]) Stars : \(parts[1])"
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
