//
//  TableVC.swift
//  ChefPlate
//
//  Created by Shane Rosse on 4/9/16.
//  Copyright © 2016 Shane Rosse. All rights reserved.
//

import UIKit

class TableVC: UITableViewController {
    
    
    let plates: Plates = Plates()
    var names: [String] = []
    var refreshCon: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plates.startUp()
        self.refreshCon = UIRefreshControl()
        self.refreshCon.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshCon.addTarget(self, action: #selector(refreshTouch), forControlEvents: .ValueChanged)
        self.tableView.addSubview(self.refreshCon)
    }
    
    //    override func viewWillAppear(animated: Bool) {
    //        refreshTable()
    //    }
    //
    //    override func viewDidAppear(animated: Bool) {
    //        refreshTable()
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshTable() {
        names = plates.getNames()
        self.tableView.reloadData()
    }
    
    func refreshTouch(sender: AnyObject) {
        refreshTable()
        self.refreshCon.endRefreshing()
    }
    @IBAction func clearTouch(sender: AnyObject) {
        plates.cleanUp()
        let alert: UIAlertController = UIAlertController(title: "Pi Kappa Phi", message: "Thank you!", preferredStyle: .Alert)
        let action: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) in
            self.refreshTable()
        })
        alert.addAction(action)
        self.presentViewController(alert, animated: true) {
        }
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
        return 60
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
