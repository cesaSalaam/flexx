//
//  signUpPart2Controller.swift
//  FlexxRide
//
//  Created by Cesa Salaam on 4/20/17.
//  Copyright © 2017 Cesa Salaam. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class signUpPart2Controller: UIViewController {

    var phoneNumber: String!
    var emailVar : String!
    var passwordVar : String!
    var thisUser:userObject = userObject()
    
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    
    @IBAction func createAccount(_ sender: Any) {
        thisUser.email = emailVar
        thisUser.password = passwordVar
        thisUser.firstName = firstName.text!
        thisUser.lastName = lastName.text!
        thisUser.phoneNumber = phoneNumber
        
        print("email: \(thisUser.email!)")
        print("phone: \(thisUser.phoneNumber!)")
        print("password: \(thisUser.password!)")
        
        FIRAuth.auth()?.createUser(withEmail: (thisUser.email)!, password: (thisUser.password)!) { (user, error) in
            
            if error == nil {
                print("You have successfully signed up")
                fireServices.FIRBase.createNewDriver(user: self.thisUser, completionHandler: { (thisValue) in
                    if thisValue == true{
                        print("User data created")
                        self.performSegue(withIdentifier: "toMain", sender: nil)}
                })
            } else {
                
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = true
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
