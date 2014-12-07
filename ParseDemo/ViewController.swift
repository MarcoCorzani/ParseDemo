//
//  ViewController.swift
//  ParseDemo
//
//  Created by Marco F.A. Corzani on 06.12.14.
//  Copyright (c) 2014 Alphaweb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var parseResults: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let query = PFQuery(className: "messages")
        
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock { (results:[AnyObject]!, error: NSError?) -> Void in
        
       if error == nil{
                
                for result in results {
                    let message = result as PFObject
                    self.parseResults.text = self.parseResults.text + "\n"  + (message["Content"] as String)
                }
                
                
            }
        }
    
    
    }

    // Upload nach Parse!
    
    @IBAction func sendMessage(sender: AnyObject) {
    
        let messageObject = PFObject(className: "messages")
        messageObject["Content"] = messageTextField.text
        //messageObject.saveInBackgroundWithTarget(nil, selector: nil)
        messageObject.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if success == true {
            self.messageTextField.text = ""
            
            }
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

