//
//  verifyCodeController.swift
//  FlexxRide
//
//  Created by Cesa Salaam on 4/18/17.
//  Copyright © 2017 Cesa Salaam. All rights reserved.
//

import UIKit
import  FirebaseDatabase
import FirebaseAuth
class verifyCodeController: UIViewController{
    
    
    //MARK: - Outlets and Variables
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var codeField: UITextField!
    var code : String?
    var phoneNumber: String?
    var firsName: String?
    var lastName: String?
    var email: String?
    
    var userObj: userObject?
    
    @IBOutlet weak var senToPhoneLabel: UILabel!
    @IBOutlet weak var resendBtn: UIButton!
    
    //MARK: - Functions
    @IBAction func next(_ sender: Any) {
        phoneNumber = phoneNumber?.replacingOccurrences(of: "(", with: "")
        phoneNumber = phoneNumber?.replacingOccurrences(of: ")", with: "")
        phoneNumber = phoneNumber?.replacingOccurrences(of: " ", with: "")
        phoneNumber = phoneNumber?.replacingOccurrences(of: "-", with: "")
        if code == codeField.text{
            isNumberInUse()
        }
    }
    
//    switch(Value){
//    case true:
//    print("false switch verify")
//    self.performSegue(withIdentifier: "nextMap", sender: nil)
//    //logInUser(completeionBlockHandler: { () in }
//    break
//    case false:
//    print("false switch verify")
//    self.performSegue(withIdentifier: "toEmail", sender: nil)
//    break
//    }
    
    @IBAction func resendClicked(_ sender: Any) {
        //Resending Code.
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
                    self.code = json["code"]!! as? String //-> This is the code the is returned from the api call
                }
            }catch{
                print("error with serializing JSON: \(error)") // printing error
            }
        }
        task.resume()
    }
    
    func isNumberInUse(){
        phoneNumber = phoneNumber?.replacingOccurrences(of: "(", with: "")
        phoneNumber = phoneNumber?.replacingOccurrences(of: ")", with: "")
        phoneNumber = phoneNumber?.replacingOccurrences(of: " ", with: "")
        phoneNumber = phoneNumber?.replacingOccurrences(of: "-", with: "")

        let scriptURL = "https://flexx2we34re6.herokuapp.com/api/check/rider/account_exists?"
        let urlWithParams = scriptURL + "number=\(phoneNumber!)"
        let myUrl = NSURL(string: urlWithParams)
        let request = NSMutableURLRequest(url: myUrl! as URL)
        request.httpMethod = "GET"
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                DispatchQueue.main.async {
                    if json["user_exists"]!! as! Bool == true{
                        print("value1: \(json["user_exists"]!!)")
                        self.userObj?.firstName = json["firstName"]!! as? String
                        self.userObj?.lastName = json["lastName"]!! as? String
                        self.userObj?.email = json["email"]!! as? String
                        self.performSegue(withIdentifier: "toLogIn", sender: nil)
                    }else{
                        print("value2: \(json["user_exists"]!!)")
                        self.performSegue(withIdentifier: "toEmail", sender: nil)
                    }
                }
            }catch{
                print("error with serializing JSON: \(error)") // printing error
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeField.maxLength = 4
        resendBtn.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        resendBtn.layer.cornerRadius = 4 //0.5*resendBtn.bounds.size.width
        resendBtn.clipsToBounds = true
        resendBtn.layer.borderWidth = 1
        resendBtn.layer.borderColor = UIColor.darkGray.cgColor
        self.navigationController?.navigationBar.isTranslucent = true
        senToPhoneLabel.text = "Enter the code sent to  your phone."
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "toEmail":
            let newController = segue.destination as! SignUpController
            newController.phoneNumber = self.phoneNumber!
            break
            
        case "toLogIn":
            let newController = segue.destination as! logInController
            newController.userObj = self.userObj
            break
        default:
            break
        }
    }
}
