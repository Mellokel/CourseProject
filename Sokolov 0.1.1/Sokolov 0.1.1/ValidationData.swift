//
//  ValidationData.swift
//  Sokolov 0.1.1
//
//  Created by test on 6/6/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import UIKit

class  Validation {
    func validationEmail(email :String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx, options: NSRegularExpressionOptions.CaseInsensitive)
            let results = regex.numberOfMatchesInString(email, options: [], range: NSMakeRange(0, email.characters.count))
            if results == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        
        }
        return returnValue
    }

}
