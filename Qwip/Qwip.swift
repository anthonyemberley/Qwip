
//
//  Qwip.swift
//  Qwip
//
//  Created by Anthony Emberley on 5/28/15.
//  Copyright (c) 2015 Qwip. All rights reserved.
//

import UIKit


class Qwip: PFObject, PFSubclassing {
    @NSManaged var username: String
    //var qwipper: Qwipper = Qwipper()
    @NSManaged var text: String
    @NSManaged var background: UIImage
    @NSManaged var favorites: NSMutableArray
    @NSManaged var reqwips: NSMutableArray
    @NSManaged var anonymous: Bool
    
    
    static func parseClassName() -> String {
        return "Qwip"
    }
    
    
    func numberOfFavorites() ->Int{
        return self.favorites.count
    }

    func numberOfReqwips() -> Int{
        return self.reqwips.count
    }
    
    func addFavorite(qwipper: Qwipper ){
        self.favorites.addObject(qwipper)
        self.saveInBackground()
        
        println(self.numberOfFavorites())
        println(self.favorites.count)

    }
    
    func addReqwip(qwipper: Qwipper){
        self.reqwips.addObject(qwipper)
        self.saveInBackground()

    }
    
    func removeFavorite(qwipper: Qwipper){
        self.favorites.removeObject(qwipper)
        self.saveInBackground()

        
    }
    
    func removeReqwip(qwipper: Qwipper){
        self.reqwips.removeObject(qwipper)
        self.saveInBackground()

        
    }
    
    
    
   
}
