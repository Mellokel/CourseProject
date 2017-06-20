//
//  MainVC.swift
//  Sokolov 0.1.1
//
//  Created by test on 6/18/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import Alamofire

class MainVC: UIViewController {
    
    
    @IBOutlet weak var webPage: UIWebView!
    
    override func viewDidLoad() {
        
        let URL = NSURL(string: "https://accounts.tsu.ru/Account/Login2")

        webPage.loadRequest(NSURLRequest(URL: URL!))
    }

    
    func some() { // т.к. я закосячил и не подал заявку в поддержку тгу аккаунтов, у меня нет некоторых данных и я не знаю, как это должно правильно выглядеть и работать
    
        let token = ""
        let applicationId = ""
        let secretKey = ""
        var accessToken = NSDictionary()
        var accountId = NSDictionary()
        
        Alamofire.request(.POST, "https://accounts.tsu.ru/api/Account", parameters: ["token":  token, "applicationId": applicationId, "secretKey":secretKey]).responseJSON { response in
                        print(response.result)                         // response serialization result
            
            if let json = response.result.value {
                
                
                accessToken = json["AccessToken"] as! NSDictionary
                accountId = json["AccountID"] as! NSDictionary
                self.performSegueWithIdentifier("MyPages", sender: nil)
            }
        }
    
    }

}