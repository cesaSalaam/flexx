//
//  userObject.swift
//  FlexxRide
//
//  Created by Cesa Salaam on 4/18/17.
//  Copyright © 2017 Cesa Salaam. All rights reserved.
//

import UIKit

class userObject: NSObject {
    var firstName : String!
    var lastName : String!
    var phoneNumber : String!
    var email : String!
    var password : String!
    
    func convertToDict() -> [String : String]{
        let dict = ["firstName" : firstName, "lastName" : lastName, "phoneNumber" : phoneNumber, "email" : email]
        return dict as! [String : String]
    }
}
