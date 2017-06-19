//
//  fireServices.swift
//  FlexxRide
//
//  Created by Cesa Salaam on 4/21/17.
//  Copyright © 2017 Cesa Salaam. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth
class fireServices: NSObject {
static let FIRBase = fireServices()
    
    let baseRef = "https://flexx-4cec3.firebaseio.com/"
    let ref = FIRDatabase.database().reference(withPath: "riders")
    
    func createNewDriver(user: userObject, completionHandler: @escaping (Bool) -> ()){
        user.phoneNumber = user.phoneNumber.replacingOccurrences(of: "(", with: "")
        user.phoneNumber = user.phoneNumber.replacingOccurrences(of: ")", with: "")
        user.phoneNumber = user.phoneNumber.replacingOccurrences(of: " ", with: "")
        user.phoneNumber = user.phoneNumber.replacingOccurrences(of: "-", with: "")
        ref.child((FIRAuth.auth()?.currentUser?.uid)!).setValue(["firstName" : user.firstName, "lastName" : user.lastName, "phoneNumber" : user.phoneNumber, "email" : user.email] as! [String: String]) { (error, FIRDatabaseReference) in
            if error == nil{
                completionHandler(true)
            }else{
                completionHandler(false)
            }
        }
    }
    
}
