//
//  SignUpViewController.swift
//  Qwip
//
//  Created by Anthony Emberley on 4/11/15.
//  Copyright (c) 2015 Qwip. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    var layer: CALayer!
    var layer2: CALayer!
    var layer3: CALayer!
    var layer4: CALayer!
    var layer5: CALayer!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.phoneNumberTextField.delegate = self
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.nameTextField.becomeFirstResponder()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        passwordTextField.secureTextEntry = true
        self.view.backgroundColor = UIColor(red:33/255.0, green:185/255.0,blue:187.0/255,alpha:1.0)

        
        // set up layers for underlines under the text fields
        
        self.layer = CALayer()
        self.layer.frame = CGRectMake(0.0, self.nameTextField.frame.size.height - 1, self.nameTextField.frame.size.width, 3.0);
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.nameTextField.layer.addSublayer(self.layer)
        self.layer2 = CALayer()
        layer2.frame = CGRectMake(0.0, self.emailTextField.frame.size.height - 1, self.emailTextField.frame.size.width, 3.0);
        layer2.borderWidth = 2.0
        layer2.borderColor = UIColor.whiteColor().CGColor
        self.emailTextField.layer.addSublayer(self.layer2)
        
        self.layer3 = CALayer()
        self.layer3.frame = CGRectMake(0.0, self.phoneNumberTextField.frame.size.height - 1, self.phoneNumberTextField.frame.size.width, 3.0);
        self.layer3.borderWidth = 2.0
        self.layer3.borderColor = UIColor.whiteColor().CGColor
        self.phoneNumberTextField.layer.addSublayer(self.layer3)
        self.layer4 = CALayer()
        layer4.frame = CGRectMake(0.0, self.usernameTextField.frame.size.height - 1, self.usernameTextField.frame.size.width, 3.0);
        layer4.borderWidth = 2.0
        layer4.borderColor = UIColor.whiteColor().CGColor
        self.usernameTextField.layer.addSublayer(self.layer4)
        
        self.layer5 = CALayer()
        self.layer5.frame = CGRectMake(0.0, self.passwordTextField.frame.size.height - 1, self.passwordTextField.frame.size.width, 3.0);
        self.layer5.borderWidth = 2.0
        self.layer5.borderColor = UIColor.whiteColor().CGColor
        self.passwordTextField.layer.addSublayer(self.layer5)
        
        
        //setting the placeholder text to a white color
        self.nameTextField.attributedPlaceholder = NSAttributedString(string:"full name",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        self.emailTextField.attributedPlaceholder = NSAttributedString(string:"email",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        self.phoneNumberTextField.attributedPlaceholder = NSAttributedString(string:"phone number",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        self.usernameTextField.attributedPlaceholder = NSAttributedString(string:"username",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string:"password",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        
        //setting the text field listener methods to textFieldDidChange to get effect when typed
        self.nameTextField.addTarget(self,
            action:"textFieldDidChange:", forControlEvents:UIControlEvents.EditingChanged)
        
        self.emailTextField.addTarget(self,
            action:"textFieldDidChange:", forControlEvents:UIControlEvents.EditingChanged)
        
        self.phoneNumberTextField.addTarget(self,
            action:"textFieldDidChange:", forControlEvents:UIControlEvents.EditingChanged)
        
        self.usernameTextField.addTarget(self,
            action:"textFieldDidChange:", forControlEvents:UIControlEvents.EditingChanged)
        
        self.passwordTextField.addTarget(self,
            action:"textFieldDidChange:", forControlEvents:UIControlEvents.EditingChanged)
       
        
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
    
    //text field methods
    
    func textFieldDidChange(textField: UITextField) {
        //delegate method
        CATransaction.setAnimationDuration(0.0)
        
        //changing the underline layer effects
        if(count(textField.text)>=1){
            
            
            if(textField == self.nameTextField){
                self.layer.borderColor = UIColor.blackColor().CGColor
            }else if(textField == self.emailTextField){
                self.layer2.borderColor = UIColor.blackColor().CGColor
            }
            else if(textField == self.phoneNumberTextField){
                self.layer3.borderColor = UIColor.blackColor().CGColor
            }
            else if(textField == self.usernameTextField){
                self.layer4.borderColor = UIColor.blackColor().CGColor
            }else if(textField == self.passwordTextField){
                self.layer5.borderColor = UIColor.blackColor().CGColor
            }
        }else{
            if(textField == self.nameTextField){
                self.layer.borderColor = UIColor.whiteColor().CGColor
            }else if(textField == self.emailTextField){
                self.layer2.borderColor = UIColor.whiteColor().CGColor
            }
            else if(textField == self.phoneNumberTextField){
                self.layer3.borderColor = UIColor.whiteColor().CGColor
            }
            else if(textField == self.usernameTextField){
                self.layer4.borderColor = UIColor.whiteColor().CGColor
            }else if(textField == self.passwordTextField){
                self.layer5.borderColor = UIColor.whiteColor().CGColor
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        if(textField == self.nameTextField){
            self.emailTextField.becomeFirstResponder()
        }else if(textField == self.emailTextField){
            self.phoneNumberTextField.becomeFirstResponder()
        }
        else if(textField == self.phoneNumberTextField){
            self.usernameTextField.becomeFirstResponder()
        }
        else if(textField == self.usernameTextField){
            self.passwordTextField.becomeFirstResponder()
        }
        return true;
    }
    
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        
        var user = Qwipper()
        user.username = usernameTextField.text.lowercaseString;
        user.password = passwordTextField.text;
        user.email = emailTextField.text.lowercaseString;
        user.qwips = NSMutableArray()
        user.followers = NSMutableArray()
        user.following = NSMutableArray()
        user.followingUsernames = NSMutableArray()
        // Initialize pffiles with some sort of picture
        //If log in with facebook ust make it facebook profile or something
        user.coverPhoto = PFFile()
        user.profilePhoto = PFFile()
        
        
        let imageCover = UIImage(named: "defaultCover.png")
        let imageCoverData = UIImagePNGRepresentation(imageCover)
        let imageCoverFile = PFFile(name:"defaultCover.png", data:imageCoverData)
        imageCoverFile.saveInBackground()
        
        user.coverPhoto = imageCoverFile
        
        let imageProfile = UIImage(named: "defaultProfile.jpg")
        let imageProfileData = UIImagePNGRepresentation(imageProfile)
        let imageProfileFile = PFFile(name:"defaultProfile.jpg", data:imageProfileData)
        imageProfileFile.saveInBackground()
        
        user.profilePhoto = imageProfileFile
        
        
        
        // other fields can be set just like with PFObject
        user["phone"] = phoneNumberTextField.text;
        user["fullname"] = nameTextField.text;
        
        user.signUpInBackgroundWithBlock {
            (succeeded, error) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                self.performSegueWithIdentifier("SignupToTimeline", sender: self)
                
            } else {
                if let errorString = error!.userInfo?["error"] as? NSString {
                    var refreshAlert = UIAlertController(title: "Error", message: errorString as String, preferredStyle: UIAlertControllerStyle.Alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                        refreshAlert.dismissViewControllerAnimated(true, completion: nil)
                    }))
                    
                    
                    
                    self.presentViewController(refreshAlert, animated: true, completion: nil)
                    
                }
                // Show the errorString somewhere and let the user try again.
            }
        }
        
        
    }
    

}
