//
//  AppDelegate.swift
//  Qwip
//
//  Created by Anthony Emberley on 4/2/15.
//  Copyright (c) 2015 Qwip. All rights reserved.
//

import UIKit
import Parse


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        UINavigationBar.appearance().barTintColor = UIColor(red:33/255.0, green:185/255.0,blue:187.0/255,alpha:1.0)
        
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()   
        
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        Parse.enableLocalDatastore()
        
        //Register subclasses
        Qwip.registerSubclass()
        
        Qwipper.registerSubclass()
        
        // Initialize Parse.
        Parse.setApplicationId("IfhZs3JAex05srEfCmj8HGrsA1qgXnxomeSEIZGV", clientKey:"PIAdWdLnhjXHLK3PpP47z80rnWucuSIAU67TJpsr")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions);
        
        var storyboard: UIStoryboard   = UIStoryboard(name: "Main", bundle:nil)

        
        var currentUser =  Qwipper.currentUser()
        if currentUser != nil {
            // do stuff with the user
            var viewController: UIViewController  =  storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
            
            self.window!.rootViewController = viewController
            
            
        } else {
            // show the signup or login screen
            var viewController: UIViewController  =  storyboard.instantiateViewControllerWithIdentifier("InitialNavController") as! UINavigationController
            
            self.window!.rootViewController = viewController
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

