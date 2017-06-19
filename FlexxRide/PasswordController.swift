//
//  PasswordController.swift
//  FlexxRide
//
//  Created by Cesa Salaam on 4/21/17.
//  Copyright © 2017 Cesa Salaam. All rights reserved.
//

import UIKit

class PasswordController: UIViewController {
    var phoneNumber : String?
    var email : String?
    var passWordVar : String?
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func next(_ sender: Any) {
        passWordVar = password.text!
        self.performSegue(withIdentifier: "nextScene", sender: nil)
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isTranslucent = true
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextScene"{
            print("passwordController email: \(self.email!)")
            print("passwordController password: \(self.passWordVar!)")
            let newController = segue.destination as! signUpPart2Controller
            newController.passwordVar = self.passWordVar!
            newController.phoneNumber = self.phoneNumber!
            newController.emailVar = self.email!
        }
    }
}
