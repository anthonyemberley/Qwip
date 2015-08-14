//
//  LoginViewController.swift
//  Qwip
//
//  Created by Anthony Emberley on 4/11/15.
//  Copyright (c) 2015 Qwip. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate  {

    @IBOutlet weak var loginInfoTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var layer: CALayer!
    var layer2: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        
        //set text field delegates and make password secure entry
        self.loginInfoTextField.becomeFirstResponder()
        
        self.passwordTextField.delegate = self
        self.loginInfoTextField.delegate = self
        passwordTextField.secureTextEntry = true;
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.view.backgroundColor = UIColor(red:33/255.0, green:185/255.0,blue:187.0/255,alpha:1.0)
        
        // set up layers for underlines under the text fields

        self.layer = CALayer()
        self.layer.frame = CGRectMake(0.0, self.loginInfoTextField.frame.size.height - 1, self.loginInfoTextField.frame.size.width, 3.0);
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.loginInfoTextField.layer.addSublayer(self.layer)
        self.layer2 = CALayer()
        layer2.frame = CGRectMake(0.0, self.loginInfoTextField.frame.size.height - 1, self.loginInfoTextField.frame.size.width, 3.0);
        layer2.borderWidth = 2.0
        layer2.borderColor = UIColor.whiteColor().CGColor
        self.passwordTextField.layer.addSublayer(self.layer2)
        
        //set the placeholder text to a white color
        self.loginInfoTextField.attributedPlaceholder = NSAttributedString(string:"username, email or phone number",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string:"password",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        //add target listener to know when to change the color of the text/layer
        self.passwordTextField.addTarget(self,
            action:"textFieldDidChange:", forControlEvents:UIControlEvents.EditingChanged)
        self.loginInfoTextField.addTarget(self,
            action:"textFieldDidChange:", forControlEvents:UIControlEvents.EditingChanged)

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
    
    //MARK: - UITextField Delegate methods
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        if(textField == self.loginInfoTextField){
            self.passwordTextField.becomeFirstResponder()
        }
        return true;
    }
    
    func textFieldDidChange(textField: UITextField) {
        //delegate method
        CATransaction.setAnimationDuration(0.0)
        if(count(textField.text)>=1){
            
        
            if(textField == self.loginInfoTextField){
                self.layer.borderColor = UIColor.blackColor().CGColor
            }else{
                self.layer2.borderColor = UIColor.blackColor().CGColor
            }
        }else{
            if(textField == self.loginInfoTextField){
                self.layer.borderColor = UIColor.whiteColor().CGColor
            }else{
                self.layer2.borderColor = UIColor.whiteColor().CGColor
            }
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
//        I had the same issue, and fixed it like this:
//        
//        Let the user select a user name, email, or both. If no username is selected, set email as username. Do not allow '@' characters in the actual username field. When logging in, check if the entered login value has a '@' or not. If it does not, its a user name, so just call loginWithUsername:andPassword. If it does have a '@', then perform a user query for the user with that email. As emails are unique, there should only be one user. Get the username of the returned user, and login using that username and the password. If no user returned from the query, then we don't know of this user, so tell the user login was unsuccessful.
//        
//        It's not the prettiest solution, but it works.
        Qwipper.logInWithUsernameInBackground(loginInfoTextField.text.lowercaseString, password:passwordTextField.text) {
            (user, error) -> Void in
            if user != nil {
                // Do stuff after successful login.
                self.performSegueWithIdentifier("LoginToTimeline", sender: self)

            } else {
                // The login failed. Check error to see why.
            }
        }
        
    }

}
