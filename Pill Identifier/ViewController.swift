//
//  ViewController.swift
//  Pill Identifier
//
//  Created by Ornicha Choungaramvong on 11/13/2558 BE.
//  Copyright © 2558 Ornicha Choungaramvong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    func printText(username:String) {
        
        print(username)
        
       // print(passwordll)
        
    }

    @IBAction func Adduser(sender: AnyObject) {
        
          self.performSegueWithIdentifier("segueIdentifier", sender: self)
    }
    
    @IBOutlet weak var txtArea: UILabel!
    @IBOutlet weak var txtColor: UILabel!
    @IBOutlet weak var txtname: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    @IBAction func takePhoto(sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func Album(sender: AnyObject) {
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)    }
    @IBAction func edgeClick(sender: AnyObject) {
        
        let image = imageView.image
        //let edge = TestOpenCV.DetectEdgeWithImage(image);
//        let gau = TestOpenCV.Gaussian(image);
        
        let color = TestOpenCV.DetectColor(image);
//        let area = TestOpenCV.DetectArea(image);
        
//        imageView.image = gau as UIImage;
        //txtname.text = edge;
        txtColor.text = color;
//        txtArea.text = area;
        
    }
    
    
    
    @IBAction func Area(sender: AnyObject) {
        
        let image = imageView.image
        let area = TestOpenCV.DetectArea(image);
        txtArea.text = area;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //NSUserDefaults.standardUserDefaults().setObject("Magic", forKey: "num")
        
        //let number = NSUserDefaults.standardUserDefaults().objectForKey("name") as! String
        //numText.text =  number
        
        if NSUserDefaults.standardUserDefaults().objectForKey("name") == nil {
            
           
            
            txtname.text = "nil"
            
           

        }
        else {
            let name = NSUserDefaults.standardUserDefaults().objectForKey("name") as! String
            txtname.text = name
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
       // if NSUserDefaults.standardUserDefaults().objectForKey("name") == nil {
            // 1
            let loginController = UIAlertController(title: "Please enter your name", message: "Fill in the following", preferredStyle: UIAlertControllerStyle.Alert)
            // 2
            let loginAction = UIAlertAction(title: "SAVE", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
                
                let loginTextField = loginController.textFields![0] 
                
                //let passwordTextField = loginController.textFields![1] as! UITextField
                
                self.printText(loginTextField.text!)
                
            }
            loginAction.enabled = false
            // 3
            _ = UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: nil)
            
            //let forgotPasswordAction = UIAlertAction(title: "Forgot Password", style: UIAlertActionStyle.Destructive, handler: nil)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            // 4
            loginController.addTextFieldWithConfigurationHandler { (textField:UITextField!) -> Void in
                
                textField.placeholder = "name"
                
                textField.keyboardType = UIKeyboardType.EmailAddress
                
                NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue(), usingBlock: { (notification:NSNotification!) -> Void in
                    
                    let textField = notification.object as! UITextField
                    
                    loginAction.enabled = !textField.text!.isEmpty
                    
                })
                
            }
            // 5
            loginController.addTextFieldWithConfigurationHandler { (textField:UITextField!) -> Void in
                
                textField.placeholder = "Password"
                
                textField.secureTextEntry = true
                
            }
            // 6
            loginController.addAction(loginAction)
           // loginController.addAction(signupAction)
//            loginController.addAction(forgotPasswordAction)
            loginController.addAction(cancelAction)
            // 7
            presentViewController(loginController, animated: true, completion: nil)

            
      //  }
//        else {
//            let number = NSUserDefaults.standardUserDefaults().objectForKey("num") as! String
//            numText.text =  number
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

