//
//  TimelineTableViewController.swift
//  Qwip
//
//  Created by Anthony Emberley on 4/3/15.
//  Copyright (c) 2015 Qwip. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {
    
    var timelineData:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.loadData()
        if (((Qwipper.currentUser())) != nil){
            var loginAlert:UIAlertController = UIAlertController(title: "Signup or Login", message: "Please login", preferredStyle: UIAlertControllerStyle.Alert)
            
            //if we want to add a spot to login right here - would rather just do the login screen
            
//            loginAlert.addTextFieldWithConfigurationHandler({
//                textField in
//                textField.placeholder = "Username"
//                
//            })
//            loginAlert.addTextFieldWithConfigurationHandler({
//                textField in
//                textField.placeholder = "Password"
//                textField.secureTextEntry = true
//                
//            })
//            loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: (
//                
//                alertAction in
//                let textFields:NSArray = loginAlert.textFields as NSArray
//                
//            
//            )))
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.timelineData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:QuoteTableViewCell = tableView.dequeueReusableCellWithIdentifier("DefaultQwip", forIndexPath: indexPath) as! QuoteTableViewCell
        
        var qwip:Qwip = self.timelineData.objectAtIndex(indexPath.row) as! Qwip
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.numberFavorites.text =  String(qwip.numberOfFavorites())
        cell.numberReqwips.text =  String(qwip.numberOfReqwips())
        
        
        cell.favoriteButton.tag = indexPath.row
        cell.reqwipButton.tag = indexPath.row
        
        cell.favoriteButton.addTarget(self, action: "favoriteTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.reqwipButton.addTarget(self, action: "reqwipTapped:" , forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.quoteTextView.text = qwip.text as String
        
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        cell.timeStampLabel.text = dateFormatter.stringFromDate(qwip.createdAt!)
        
        var findQuoter:PFQuery = Qwipper.query()!
        //        findQuoter.whereKey("objectId", equalTo: quote.objectForKey("quoter").objectId)
        //        findQuoter.findObjectsInBackgroundWithBlock{
        //            (objects:[AnyObject]!, error:NSError!) -> Void in
        //            if error ==  nil{
        //                let objectsArray:NSArray = objects as NSArray
        //                let objects = objects as PFUser
        //                let user:PFUser = objects
        var qwipper:NSString = qwip.username as NSString

        
        if qwip.anonymous{
            cell.usernameButton.setTitle("anonymous", forState: UIControlState.Normal);
            cell.usernameButton.enabled = false
        }
        else{
            cell.usernameButton.addTarget(self, action: "usernameTapped:" , forControlEvents: UIControlEvents.TouchUpInside)
            cell.usernameButton.setTitle(qwipper as String, forState: UIControlState.Normal)
            cell.usernameButton.enabled = true
        }
        
        
//        cell.quoteTextView.alpha = 0
//        cell.usernameButton.alpha = 0
//        cell.timeStampLabel.alpha = 0
        
        
        
        //animations
//        UIView.animateWithDuration(0.5, animations: {
//            cell.quoteTextView.alpha = 1
//            cell.usernameButton.alpha = 1
//            cell.timeStampLabel.alpha = 1
//            
//              })
//            }
//        }
        
//        findTimelineData.findObjectsInBackgroundWithBlock{
//            (objects:[AnyObject]!, error:NSError!)->Void in
//            
//            if error == nil{
//                
//                if let objects = objects as? [PFObject] {
//                    for object in objects {
//                        self.timelineData.addObject(object)                    }
//                }
//                
//                
//            }
//            var array:NSArray = self.timelineData.reverseObjectEnumerator().allObjects
//            self.timelineData =  array as NSMutableArray
//            
//            self.tableView.reloadData()
//            
//        }
        
        
        //think about optionals

        // Configure the cell...
        

        return cell
    }
    
    
    func favoriteTapped(button: UIButton){
        let row = button.tag
        println(row)
        
        let cell:QuoteTableViewCell = tableView.dequeueReusableCellWithIdentifier("DefaultQwip", forIndexPath: NSIndexPath(forRow: row, inSection: 0)) as! QuoteTableViewCell
        
        
        var qwipTouched: Qwip  = self.timelineData.objectAtIndex(row) as! Qwip
        
        print(qwipTouched.text)
        var favorites: NSMutableArray = qwipTouched.favorites
        
        if favorites.containsObject(Qwipper.currentUser()!){
            qwipTouched.removeFavorite(Qwipper.currentUser()!)
            
            
        }else{
            qwipTouched.addFavorite(Qwipper.currentUser()!)
            
        }
        qwipTouched.saveInBackground()
        
        cell.numberFavorites.text  =  String(qwipTouched.numberOfFavorites())
        
        self.tableView.reloadRowsAtIndexPaths([NSIndexPath](arrayLiteral: NSIndexPath(forRow: row, inSection: 0)), withRowAnimation: UITableViewRowAnimation.None)
        
        
        
    }
    
    func reqwipTapped(button: UIButton){
        let row = button.tag
        
        let cell:QuoteTableViewCell = tableView.dequeueReusableCellWithIdentifier("DefaultQwip", forIndexPath: NSIndexPath(forRow: row, inSection: 0)) as! QuoteTableViewCell
        
        var qwipTouched: Qwip  = self.timelineData.objectAtIndex(row) as! Qwip
        
        if qwipTouched.reqwips.containsObject(Qwipper.currentUser()!){
            qwipTouched.removeReqwip(Qwipper.currentUser()!)
            
        }else{
            qwipTouched.addReqwip(Qwipper.currentUser()!)
            
        }
        //Then add qwip to the persons qwips
        qwipTouched.saveInBackground()
        
        
        cell.numberFavorites.text  =  String(qwipTouched.numberOfReqwips())
        
        self.tableView.reloadRowsAtIndexPaths([NSIndexPath](arrayLiteral: NSIndexPath(forRow: row, inSection: 0)), withRowAnimation: UITableViewRowAnimation.None)
    }
    
    func usernameTapped(button: UIButton){
        self.performSegueWithIdentifier("toProfileViewController", sender: button)
        
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    
    


    @IBAction func refreshButtonPressed(sender: AnyObject) {
        self.loadData()
    }
    
    
    
    func loadData(){
        timelineData.removeAllObjects()
        var findTimelineData:PFQuery = PFQuery(className: "Qwip")
        
   
        //to be able to only see following qwips
        
        findTimelineData.whereKey("username", containedIn: Qwipper.currentUser()?.followingUsernames as! [String])
        findTimelineData.orderByDescending("createdAt")
        findTimelineData.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]?, error:NSError?)->Void in
            
            if error == nil{
                
                if let objects = objects as? [Qwip] {
                    for object in objects {
                        self.timelineData.addObject(object)                    }
                }
               
                
            }
            
            self.tableView.reloadData()
            
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "toProfileViewController") {
            // pass data to next view
            let viewController:ProfileViewController = segue.destinationViewController as! ProfileViewController
            
            let button:UIButton  = sender as! UIButton
            
            viewController.qwipperUserString = button.titleLabel!.text!

            
            
        }
    }

}
