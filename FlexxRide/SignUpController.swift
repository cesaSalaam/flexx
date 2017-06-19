//
//  SignUpController.swift
//  FlexxRide
//
//  Created by Cesa Salaam on 4/19/17.
//  Copyright © 2017 Cesa Salaam. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!

    var phoneNumber: String?
    var email : String?
    
    @IBAction func nextClicked(_ sender: Any) {
        email = emailTextField.text!
        if validateEmail(enteredEmail: email!){
            self.performSegue(withIdentifier: "toPassword", sender: nil)
        } else{
            let alertController = UIAlertController(title: "Sorry", message: "Please enter a valid email", preferredStyle: .actionSheet)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPassword"{
            let newController = segue.destination as! PasswordController
            newController.email = self.email!
            newController.phoneNumber = self.phoneNumber!
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
