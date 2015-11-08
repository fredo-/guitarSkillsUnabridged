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
    
    var brains: GuitarSkillsBrains()
    
    //---------------------THIS FUNCTION STARTS THE INITIALIZATION OF THE MODEL------------------------
    @IBAction func makeModel(sender: AnyObject) {
        Parse.setApplicationId("KWg6vkp0BCIux6pQpftK9oc1M2q6wltAxT7xdba7", clientKey: "3UYovk71VCPwYaiVtH4M1TfE97rcPogwA13D9LUn")
        //Query database to get the user info
        let usrlogin = brains.emailToDBID
        let usrInfo = PFQuery(className: "users_table")
        usrInfo.getObjectInBackgroundWithId(usrlogin) {
            (gameScore: PFObject?, error: NSError?) -> Void in
            if error == nil && gameScore != nil {
                print(gameScore)
            } else {
                print(error)
            }
        }
    }
    //Properties:
    @IBOutlet weak var userName: UITextField!
    
}

