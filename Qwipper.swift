//
//  Qwipper.swift
//  Qwip
//
//  Created by Anthony Emberley on 5/28/15.
//  Copyright (c) 2015 Qwip. All rights reserved.
//
//
/*
This class represents the user that writes the qwips.  They have a set of followers, 
people they are following and qwips they have written themselves.



*/

import UIKit
import Foundation

class Qwipper: PFUser, PFSubclassing{
    //var username: NSString = ""
    //var email: NSString = ""
    @NSManaged var qwips :  NSMutableArray
    @NSManaged var followers : NSMutableArray
    @NSManaged var following : NSMutableArray
    @NSManaged var followingUsernames :  NSMutableArray
    @NSManaged var coverPhoto: PFFile;
    @NSManaged var profilePhoto: PFFile;
    
    
    func followNew(qwipper: Qwipper){
        self.following.addObject(qwipper);
        self.followingUsernames.addObject(qwipper.username!)
        self.saveInBackground()

    }
    
    func removeFollow(qwipper: Qwipper){
        self.following.removeObject(qwipper)
        
        self.followingUsernames.removeObject(qwipper.username!)

        self.saveInBackground()
    }
    
    func addNewFollower(qwipper: Qwipper){
        self.followers.addObject(qwipper)
        self.saveInBackground()

    }
    
    func removeFollower(qwipper: Qwipper){
        self.followers.removeObject(qwipper)
        self.saveInBackground()

    }
    
    func addNewQwip(qwip: Qwip){
        qwips.addObject(qwip)
        
    }
    
    
    
}
