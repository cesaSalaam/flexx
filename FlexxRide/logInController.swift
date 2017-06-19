//
//  logInController.swift
//  FlexxRide
//
//  Created by Cesa Salaam on 6/18/17.
//  Copyright © 2017 Cesa Salaam. All rights reserved.
//

import UIKit

class logInController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var password: UITextField!
    
    var userObj: userObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = "WELCOME \(String(describing: userObj?.firstName!))"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInClicked(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: userObj?.email, password: password.text, completion: <#T##FIRAuthResultCallback?##FIRAuthResultCallback?##(FIRUser?, Error?) -> Void#>)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
