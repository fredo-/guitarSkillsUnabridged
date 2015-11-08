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

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    
    //Properties:
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var posPs: UITextField!
    let guitarAppDBid = "KWg6vkp0BCIux6pQpftK9oc1M2q6wltAxT7xdba7"
    let fredoClientKeyDB = "3UYovk71VCPwYaiVtH4M1TfE97rcPogwA13D9LUn"
    var brains =  GuitarSkillsBrains()
    
    //Functionality
    //---------------------THIS FUNCTION STARTS THE INITIALIZATION OF THE MODEL------------------------
    @IBAction func makeModel() {
        //Query Parse database to get user info, password and id
        Parse.setApplicationId(guitarAppDBid, clientKey: fredoClientKeyDB)
        checkLoginInfo()
    }
    
    func checkLoginInfo(){
        let usrlogin = brains.emailToDBID[userName.text!]
        let usrInfo = PFQuery(className: "users_table")
        usrInfo.getObjectInBackgroundWithId(usrlogin!) {
            (userRow: PFObject?, error: NSError?) -> Void in
            if error == nil && userRow != nil {
                let actualPsw = userRow!["password"]
                if String(actualPsw) == self.posPs.text! {
                    print("You entered the correct pasword!")
                }else{
                    print("Hit the road bum")
                }
            } else {
                print(error)
            }
            
        }
    }
}

