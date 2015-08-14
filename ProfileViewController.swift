//
//  ProfileViewController.swift
//  Qwip
//
//  Created by Anthony Emberley on 6/13/15.
//  Copyright (c) 2015 Qwip. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var qwipsTableView: UITableView!
    var qwipper = Qwipper()
    var qwipperUserString = ""
    var qwipData:NSMutableArray = NSMutableArray()
    var cellIdentifier:String = "DefaultQwip"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.qwipsTableView.delegate = self
        self.qwipsTableView.dataSource = self

        println("qwipper: " + self.qwipperUserString)
        
        
        
        
        //unpack the pffiles with the two pictures in them
        
        var query = Qwipper.query()
        query!.whereKey("username", equalTo:qwipperUserString)
        query!.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]?, error:NSError?)->Void in
            
            if error == nil{
                
                if let objects = objects as? [Qwipper] {
                    for object in objects {
                        self.qwipper = object
                    }
                    var followingString:String = "following: " + String(self.qwipper.following.count)
                    self.followingButton.setTitle(followingString, forState: UIControlState.Normal)
                    var followersString:String = "followers: " + String(self.qwipper.followers.count)
                    self.followersButton.setTitle(followersString, forState: UIControlState.Normal)
                    let userCoverFile = self.qwipper.coverPhoto as PFFile
                    userCoverFile.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        if error == nil {
                            if let coverImageData = imageData {
                                let coverImage = UIImage(data:coverImageData)
                                self.backgroundImageView.image = coverImage
                                
                            }
                            else{
                                println("here")
                            }
                        }else{
                            println(error?.localizedDescription)
                        }
                    }
                    let userProfileFile = self.qwipper.profilePhoto as PFFile
                    userProfileFile.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        if error == nil {
                            if let profileImageData = imageData {
                                let profileImage = UIImage(data:profileImageData)
                                self.profileImageView.image = profileImage
                                
                            }
                            else{
                                println("here")
                            }
                        }else{
                            println(error?.localizedDescription)
                        }
                    }
                    self.loadData()

                
                }
                
            }
            
        }
        
        
        
        
        
        
        
        //load the first 10-20 qwips

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.qwipData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let array = self.qwipData
//        let row = indexPath.row
        
        
        let cell:QuoteTableViewCell = tableView.dequeueReusableCellWithIdentifier("DefaultQwip", forIndexPath: indexPath) as! QuoteTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        var qwip:Qwip = self.qwipData.objectAtIndex(indexPath.row) as! Qwip
        
        cell.numberFavorites.text =  String(qwip.numberOfFavorites())
        cell.numberReqwips.text =  String(qwip.numberOfReqwips())
        
        
        cell.favoriteButton.tag = indexPath.row
        cell.reqwipButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: "favoriteTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.reqwipButton.addTarget(self, action: "reqwipTapped:" , forControlEvents: UIControlEvents.TouchUpInside)
        cell.usernameButton.addTarget(self, action: "usernameTapped:" , forControlEvents: UIControlEvents.TouchUpInside)
        
//        cell.favoriteButton.addTarget(self, action: "favoriteTapped:", forControlEvents: UIControlEvents.TouchUpInside)
//        cell.reqwipButton.addTarget(self, action: "reqwipTapped:" , forControlEvents: UIControlEvents.TouchUpInside)
//        cell.usernameButton.addTarget(self, action: "usernameTapped:" , forControlEvents: UIControlEvents.TouchUpInside)
        //        cell.quoteTextView.alpha = 0
        //        cell.usernameButton.alpha = 0
        //        cell.timeStampLabel.alpha = 0
        
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
        
        cell.usernameButton.setTitle(qwipper as String, forState: UIControlState.Normal)
        
    
        return cell
    }


   
    
    func loadData(){
        qwipData.removeAllObjects()
        var findqwipData:PFQuery = PFQuery(className: "Qwip")
        
        //        query.findObjectsInBackgroundWithBlock {
        //            (objects: [AnyObject]!, error: NSError!) -> Void in
        //            if error == nil {
        //                // The find succeeded.
        //                println("Successfully retrieved \(objects.count) scores.")
        //                // Do something with the found objects
        //                if let objects = objects as? [PFObject] {
        //                    for object in objects {
        //                        println(object.objectId)
        //                    }
        //                }
        //            } else {
        //                // Log details of the failure
        //                println("Error: \(error) \(error.userInfo!)")
        //            }
        //        }
        
        findqwipData.whereKey("username", equalTo: self.qwipperUserString)
        findqwipData.orderByDescending("createdAt")
        findqwipData.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]?, error:NSError?)->Void in
            
            if error == nil{
                
                if let objects = objects as? [Qwip] {
                    for object in objects {
                        if !object.anonymous{
                        self.qwipData.addObject(object)
                        }
                    }
                }
                
                
            }
            
            
            self.qwipsTableView.reloadData()
            
        }
        
    }
   
    
    @IBAction func followButtonTapped(sender: AnyObject) {
        
        if self.qwipper.followers.containsObject(Qwipper.currentUser()!){
            self.qwipper.removeFollower(Qwipper.currentUser()!)
            Qwipper.currentUser()?.removeFollow(self.qwipper)
            
        }else{
            self.qwipper.addNewFollower(Qwipper.currentUser()!)
            Qwipper.currentUser()?.followNew(self.qwipper)
        }
        
        
    }
    
    
    
    func favoriteTapped(button: UIButton){
        let row = button.tag
        println(row)
        
        let cell:QuoteTableViewCell = qwipsTableView.dequeueReusableCellWithIdentifier("DefaultQwip", forIndexPath: NSIndexPath(forRow: row, inSection: 0)) as! QuoteTableViewCell
        
        
        var qwipTouched: Qwip  = self.qwipData.objectAtIndex(row) as! Qwip
        
        print(qwipTouched.text)
        var favorites: NSMutableArray = qwipTouched.favorites
        
        if favorites.containsObject(Qwipper.currentUser()!){
            qwipTouched.removeFavorite(Qwipper.currentUser()!)
            
            
        }else{
            qwipTouched.addFavorite(Qwipper.currentUser()!)
            
        }
        qwipTouched.saveInBackground()
        
        cell.numberFavorites.text  =  String(qwipTouched.numberOfFavorites())
        
        self.qwipsTableView.reloadRowsAtIndexPaths([NSIndexPath](arrayLiteral: NSIndexPath(forRow: row, inSection: 0)), withRowAnimation: UITableViewRowAnimation.None)
        
        
        
    }
    
    func reqwipTapped(button: UIButton){
        let row = button.tag
        
        let cell:QuoteTableViewCell = qwipsTableView.dequeueReusableCellWithIdentifier("DefaultQwip", forIndexPath: NSIndexPath(forRow: row, inSection: 0)) as! QuoteTableViewCell
        
        var qwipTouched: Qwip  = self.qwipData.objectAtIndex(row) as! Qwip
        
        if qwipTouched.reqwips.containsObject(Qwipper.currentUser()!){
            qwipTouched.removeReqwip(Qwipper.currentUser()!)
            
        }else{
            qwipTouched.addReqwip(Qwipper.currentUser()!)
            
        }
        //Then add qwip to the persons qwips
        qwipTouched.saveInBackground()
        
        
        cell.numberFavorites.text  =  String(qwipTouched.numberOfReqwips())
        
        self.qwipsTableView.reloadRowsAtIndexPaths([NSIndexPath](arrayLiteral: NSIndexPath(forRow: row, inSection: 0)), withRowAnimation: UITableViewRowAnimation.None)
    }
    
    func usernameTapped(button: UIButton){
        self.performSegueWithIdentifier("profileToProfile", sender: button)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "profileToProfile") {
            // pass data to next view
            let viewController:ProfileViewController = segue.destinationViewController as! ProfileViewController
            
            let button:UIButton  = sender as! UIButton
            
            viewController.qwipperUserString = button.titleLabel!.text!
            
            
            
        }
        else if(segue.identifier == "followingSegue"){
            let viewController:ManyQwippersTableViewController = segue.destinationViewController as! ManyQwippersTableViewController
            viewController.tableViewTitle = "following"
            print(qwipper.following.count)
            viewController.qwippersArray = qwipper.following

            
        }
        
        else if (segue.identifier == "followersSegue"){
            let viewController:ManyQwippersTableViewController = segue.destinationViewController as! ManyQwippersTableViewController
            print(qwipper.followers.count)

            viewController.tableViewTitle = "followers"
            viewController.qwippersArray = qwipper.followers
            
        }
        
        
        
    }
    
    @IBOutlet weak var followersButtonPressed: UIButton!
    @IBAction func followingButtonPressed(sender: AnyObject) {
    }
    

}
