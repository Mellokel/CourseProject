//
//  ParseJSON.swift
//  Sokolov 0.1.1
//
//  Created by test on 4/27/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation

class ParseJSON {

    static var instance = ParseJSON()
    
    
    func parseWithoutId(json: JSON, first: String) -> String? {
        return json[first].string
    }
    
    
    
    func  parseWithId(json: JSON, id: Int, first: String) -> String? {
        return json[id][first].string
    }
    
    func parseGetDictionary(json: JSON, first: String) -> [String:String]? {
        var array = [String:String]()
        
        for index in 0...json.count-1 {
            
            array[json[index]["idPage"].string!] = json[index]["Name"].string!
            
        }
        return array
    }
   
    
    

}