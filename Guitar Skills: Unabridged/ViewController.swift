//
//  ViewController.swift
//  Guitar Skills: Unabridged
//
//  Created by Alfredo J. Velasco on 11/8/15.
//  Copyright © 2015 Wolf Picks. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Properties:
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var posPs: UITextField!
    
   
    var brains =  GuitarSkillsBrains()
    
    //---------------------THIS FUNCTION STARTS THE INITIALIZATION OF THE MODEL------------------------
    @IBAction func makeModel() {
        Parse.setApplicationId("KWg6vkp0BCIux6pQpftK9oc1M2q6wltAxT7xdba7", clientKey: "3UYovk71VCPwYaiVtH4M1TfE97rcPogwA13D9LUn")
        
        //Query database to get the user info
        let usrlogin = brains.emailToDBID[String(userName.text!)]
        let usrInfo = PFQuery(className: "users_table")
        
        //Check the password
        usrInfo.getObjectInBackgroundWithId(usrlogin!) {
            (userRow: PFObject?, error: NSError?) -> Void in
            if error == nil && userRow != nil {
                let actualPsw = userRow!["password"]
                if String(actualPsw) == self.posPs.text! {
                    print("You entered the correct pasword!")
                }else{
                    print("Hit the road bum")
                }
                
                //print(actualPsw)
                //print(self.posPs.text!)
            } else {
                print(error)
            }
        }

    
    }
    
    
}

