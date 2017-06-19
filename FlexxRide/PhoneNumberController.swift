//
//  PhoneNumberController.swift
//  FlexxRide
//
//  Created by Cesa Salaam on 4/17/17.
//  Copyright © 2017 Cesa Salaam. All rights reserved.
//

import UIKit
import FirebaseAuth
class PhoneNumberController: UIViewController, UITextFieldDelegate {

    // MARK: - Variables and Outlets
    @IBOutlet weak var phone: UITextField!
    
    var phoneNumber: String? // This Variables stores the Phone number that the users takes in.
    
    var currentCode:String? // This Variable stores the Code that is returned from the API call.
    
    @IBAction func nextClicked(_ sender: Any) {
        //Action for 'Next' button.
        //When this button is clicked, we hit the "https://flexx2we34re6.herokuapp.com/api/verify/sms?" api to return a verification code.
        phoneNumber = phone.text?.replacingOccurrences(of: "(", with: "")
        phoneNumber = phoneNumber?.replacingOccurrences(of: ")", with: "")
        phoneNumber = phoneNumber?.replacingOccurrences(of: "-", with: "")
        phoneNumber = phoneNumber?.replacingOccurrences(of: " ", with: "")
        
        if (phoneNumber?.characters.count)! < 10 || (phoneNumber?.characters.count)! > 10 {
            let alertController = UIAlertController(title: "Error", message: "Invalid Phone Number", preferredStyle: .actionSheet)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }else{
            let scriptURL = "https://flexx2we34re6.herokuapp.com/api/verify/sms?"
            let urlWithParams = scriptURL + "number=\(phoneNumber!)"
            let myUrl = NSURL(string: urlWithParams)
            let request = NSMutableURLRequest(url: myUrl! as URL)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                    DispatchQueue.main.async {
                        self.phoneNumber = self.phone.text!
                        self.currentCode = json["code"]!! as? String //-> This is the code the is returned from the api call
                        self.performSegue(withIdentifier: "toVerifyCode", sender: nil)
                    }
                    
                }catch{
                    print("error with serializing JSON: \(error)") // printing error
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Closing keyboard when background is touched
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addDoneButtonOnKeyboard()
        self.navigationController?.navigationBar.isTranslucent = true
        phone.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let str = (phone.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField == phone{
            
            return checkEnglishPhoneNumberFormat(string: string, str: str)
            
        }else{
            
            return true
        }
    }
    
    func checkEnglishPhoneNumberFormat(string: String?, str: String?) -> Bool{
        
        if string == ""{ //BackSpace
            
            return true
            
        }else if str!.characters.count < 3{
            
            if str!.characters.count == 1{
                
                phone.text = "("
            }
            
        }else if str!.characters.count == 5{
            
            phone.text = phone.text! + ") "
            
        }else if str!.characters.count == 10{
            
            phone.text = phone.text! + "-"
            
        }else if str!.characters.count > 14{
            
            return false
        }
        
        return true
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Passing data from this controller to next ctroller
        //Passing the Phone number and the verification code.
        
        if segue.identifier == "toVerifyCode"{
            let newController = segue.destination as! verifyCodeController
            newController.code = self.currentCode!
            newController.code = newController.code?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            newController.phoneNumber = self.phoneNumber!
        }
    }
}
