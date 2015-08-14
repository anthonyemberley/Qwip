//
//  NewQuoteViewController.swift
//  Qwip
//
//  Created by Anthony Emberley on 4/3/15.
//  Copyright (c) 2015 Qwip. All rights reserved.
//

import UIKit

class NewQuoteViewController: UIViewController {

    @IBOutlet var anonymousButton: UIButton!
    @IBOutlet weak var newQuoteTextView: UITextView!
    
    @IBOutlet weak var anonymousSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        newQuoteTextView.layer.borderColor = UIColor.blackColor().CGColor
        newQuoteTextView.layer.borderWidth = 0.5
        newQuoteTextView.layer.cornerRadius = 5
        newQuoteTextView.becomeFirstResponder()
        self.automaticallyAdjustsScrollViewInsets = false;
        anonymousButton.backgroundColor = UIColor.blueColor();

        // Do any additional setup after loading the view.
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
    
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
//        var newQuote:PFObject = PFObject(className: "quotes");
        //var tempQwipper = Qwipper()
        
        var newQwip:Qwip = Qwip(className: "Qwip")
        newQwip.reqwips = NSMutableArray()
        newQwip.favorites = NSMutableArray()
        newQwip.username = (Qwipper.currentUser()!.username as String?)!
        newQwip.text = self.newQuoteTextView.text
        newQwip.saveInBackground()
        newQwip.anonymous = self.anonymousSwitch.on
        
        var user = Qwipper.currentUser()
        user?.addNewQwip(newQwip)
        
        NSLog("quote text view text: ", self.newQuoteTextView.text);
        //NSLog("current user text: ",  (PFUser.currentUser()!.username as String?)! );
//        newQuote["quote"] =  self.newQuoteTextView.text
//        newQuote["quoter"] =  Qwipper.currentUser()?.username
//        newQuote["favorites"] = NSMutableArray()
//        
//        
//        newQuote.saveInBackground()
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        
    }

}
