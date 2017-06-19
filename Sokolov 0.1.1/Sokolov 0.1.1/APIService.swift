//
//  Pattern.swift
//  Sokolov 0.1.1
//
//  Created by test on 3/27/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import Alamofire

protocol APIService {
    
    
    func getAllPages() -> JSON
    func getMyPages(email:String, password: String) -> JSON
    func authorization(email:String, password: String) -> Bool
    
    func getPage(id: String) -> JSON
    func getPage(id: String, name: String ) -> JSON
    func getPages(i: Int) -> JSON
   
    func getPosts(id: String) -> JSON
    func getPost(idPage: String, idPost: String) -> JSON
    
    func postLike(idPost: String)
    func postLike(idPost: String, idComment: String)
    
}

class APIRealService { // нужно редактировать т.к. необхдимо знать ссылки и что парсить, а так же все так же проблема с аккаунтом
    

    func getJSONFromServer(URL: String, parameters: [String: String] ) -> JSON{
    
        var json: JSON = []
        Alamofire.request(.GET, URL, parameters: parameters).responseJSON { response in
            print(response.result)                         // response serialization result
            if let result = response.result.value {
                json = JSON(result)
            }
        }
    return json
    
    }
    
    func getAllPages() -> JSON {
        let URL = ""
        let parameters = ["":""]
        var json: JSON = []
        
        json = getJSONFromServer(URL, parameters: parameters)
        
        return json
    }
    
    func getMyPages() -> JSON{
        let URL = ""
        let parameters = ["":""]
        var json: JSON = []
        
        json = getJSONFromServer(URL, parameters: parameters)

       
        return json

    
    
    }
    func authorization(email:String, password: String) -> JSON{
        let URL = ""
        let parameters = ["":""]
        var json: JSON = []
        json = getJSONFromServer(URL, parameters: parameters)
        json = getJSONFromServer(URL, parameters: parameters)

        return json
}
    
    
    
    func getPage(id: String) -> JSON{
        let URL = ""
        let parameters = ["":""]
        var json: JSON = []
        json = getJSONFromServer(URL, parameters: parameters)

        
        return json
}
    func getPage(id: String, name: String )-> JSON {
        let URL = ""
        let parameters = ["":""]
        var json: JSON = []
        json = getJSONFromServer(URL, parameters: parameters)

        
        return json
}
    func getPages(i: Int) -> JSON{
        let URL = ""
        let parameters = ["":""]
        var json: JSON = []
        
        json = getJSONFromServer(URL, parameters: parameters)

        return json
}
    
    func getPosts(id: String)-> JSON {
        let URL = ""
        let parameters = ["":""]
        var json: JSON = []
        json = getJSONFromServer(URL, parameters: parameters)

        return json
}
    func getPost(idPage: String, idPost: String) -> JSON{
        let URL = ""
        let parameters = ["":""]
        var json: JSON = []
        
        json = getJSONFromServer(URL, parameters: parameters)

        return json
}
    
    func postLike(idPost: String) -> JSON{
        let URL = ""
        let parameters = ["":""]
        var json: JSON = []
        json = getJSONFromServer(URL, parameters: parameters)

        return json
}
    func postLike(idPost: String, idComment: String) -> JSON{
        let URL = ""
        let parameters = ["":""]
        var json: JSON = []
        
        json = getJSONFromServer(URL, parameters: parameters)

        return json
}
    
}


class APIStubService : APIService
{
    
    func postLike(idPost: String) {}
    func postLike(idPost: String, idComment: String){}
    
    func authorization(email: String, password: String) -> Bool { //
        if (email == "aaa@gmail.com" && password == "aaa") {
        
            return true
        }
        else {
            if (email == "bbb@gmail.com"  && password == "bbb"){
                     return true
                
            }
        }
        
        
        
        
        return false
    }
    func getMyPages(email: String, password: String) -> JSON {
        
        if (email == "aaa@gmail.com" && password == "aaa") {
        
        let json = JSON([["id": "1001","name":"Соколов Николай Николаевич", "age": 1, "about": "human1"]])
            return json
        }
        else {
            if (email == "bbb@gmail.com"  && password == "bbb"){
                let json = JSON([["id": "1001","name":"Jackb", "age": 1, "about": "human1"],
                    ["id": "1002","name":"Jackb", "age": 1, "about": "human1"],
                    ["id": "1003","name":"Jackb", "age": 1, "about": "human1"],
                    ["id": "1004","name":"Jackb", "age": 1, "about": "human1"]])
                return json
            
            } else {
                let json = JSON(["access": "false"])
                return json
             }
        }
    }
    func getPage(id : String) ->JSON {
        var json = JSON(["id": "","name":"Jack", "age": "1", "about": "human1", "ownersCount": "1", "subscribersCount": "20", "recordsCount": "10"])
        
        json["id"].string = id
        json["name"].string = "Jack" + id
        
        return json
    }
    func getPage(id : String, name: String) ->JSON {
        var json = JSON(["id": "","name":"Jack", "age": 1, "about": "human1"])
        
        json["id"].string = id
        json["name"].string = name
    
    return json
    }
    func getPost(idPage: String, idPost: String) -> JSON {
        var json = JSON(
            ["idPost" : "" ,"idPage":"" , "Autor": "Jack", "Date": "13.12.2017 20:20:20", "Head": "head head head" ,"Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae. ", "Like": "2", "Comment": "2", "Repost":"0"])
        json["idPost"].string = idPost
        json["idPage"].string = idPage
        return json

    }
    func getAllPages() -> JSON {
        let json = JSON([
                ["idPage": "0001", "Name": "Jack1"],["idPage": "0009", "Name": "Jack9"],["idPage": "0017", "Name": "Jack1"],
            ["idPage": "0002", "Name": "aJack2"],["idPage": "0010", "Name": "abJack10"],["idPage": "0018", "Name": "Jack15"],
            ["idPage": "0003", "Name": "aJack3"],["idPage": "0011", "Name": "aabJack11"],["idPage": "0019", "Name": "Jack16"],
            ["idPage": "0004", "Name": "aJack4"],["idPage": "0012", "Name": "abaJack12"],["idPage": "0020", "Name": "JACK1"],
            ["idPage": "0005", "Name": "bJack5"],["idPage": "0013", "Name": "Jack13"],["idPage": "0021", "Name": "jACK1"],
            ["idPage": "0006", "Name": "bJack6"],["idPage": "0014", "Name": "Jack14"],["idPage": "0022", "Name": "JACk1"],
            ["idPage": "0007", "Name": "bJack7"],["idPage": "0015", "Name": "Jack14"],["idPage": "0023", "Name": "Jack5"],
            ["idPage": "0008", "Name": "bJack8"],["idPage": "0016", "Name": "Jack142"],["idPage": "0024", "Name": "Jack7"],
            
            ])
        return json
    }
    func getComments(idPage: String, idPost: String) -> JSON {
        let json = JSON([
            ["idPage": idPage,"idPost": idPost , "Autor": "Jack", "Head": "head head" , "Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.", "Like": "4", "Date": "13.12.2017 20:20:20"],
            ["idPage": idPage,"idPost": idPost , "Autor": "Jack", "Head": "head head" , "Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae. ", "Like": "4", "Date": "13.12.2017 20:20:20"],
            ["idPage": idPage,"idPost": idPost , "Autor": "Jack", "Head": "head head" , "Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae. ", "Like": "4", "Date": "13.12.2017 20:20:20"],
            ["idPage": idPage,"idPost": idPost , "Autor": "Jack", "Head": "head head" , "Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.", "Like": "4", "Date": "13.12.2017 20:20:20"],
            ["idPage": idPage,"idPost": idPost , "Autor": "Jack", "Head": "head head" , "Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.", "Like": "4", "Date": "13.12.2017 20:20:20"],
            ["idPage": idPage,"idPost": idPost , "Autor": "Jack","Head": "head head" , "Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae. ", "Like": "4", "Date": "13.12.2017 20:20:20"],
            ["idPage": idPage,"idPost": idPost , "Autor": "Jack","Head": "head head" , "Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae. ", "Like": "4", "Date": "13.12.2017 20:20:20"],
            ["idPage": idPage,"idPost": idPost , "Autor": "Jack","Head": "head head" , "Content": "cTemporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae. ", "Like": "4", "Date": "13.12.2017 20:20:20"],
            ["idPage": idPage,"idPost": idPost , "Autor": "Jack","Head": "head head" , "Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae. ", "Like": "4", "Date": "13.12.2017 20:20:20"],
            ["idPage": idPage,"idPost": idPost , "Autor": "Jack","Head": "head head" , "Content": "cTemporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae. ", "Like": "4", "Date": "13.12.2017 20:20:20"],
            
            ])
     return json
    }
    func getPosts(id: String) -> JSON {
        let json = JSON(
        [
            
            ["idPage": id,"idPost" : "0001" ,"Page":"page" , "Autor": "Jack", "Date": "13.12.2017 20:20:20", "Head": "head head head" , "Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae. " ],
            ["idPage": id,"idPost" : "0002" ,"Page":"page" , "Autor": "Jack", "Date": "13.12.2017 20:20:21", "Head": "head head head" , "Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae." ],
            ["idPage": id,"idPost" : "0003" ,"Page":"page" , "Autor": "Jack", "Date": "13.12.2017 20:20:22", "Head": "head head head" , "Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae." ],
            ["idPage": id,"idPost" : "0004" , "Page":"page" ,"Autor": "Jack", "Date": "13.12.2017 20:20:23", "Head": "head head head" , "Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae." ],
            ["idPage": id,"idPost" : "0005" , "Page":"page" ,"Autor": "Jack", "Date": "13.12.2017 20:20:24", "Head": "head head head" , "Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae.Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae." ],
            ["idPage": id,"idPost" : "0006" ,"Page":"page" , "Autor": "Jack", "Date": "13.12.2017 20:20:25", "Head": "head head head" , "Content": "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, quis nostrum exercitationem ullam corporis suscipit laboriosam, ut et voluptates repudiandae sint et molestiae non recusandae." ]
            
        ])
        return json
    }
    func getPages(i: Int) ->JSON {
        let json = JSON(
            [
                ["id":"0001","name":"Соколов Николай", "age": 1, "about": "human1"],
                ["id":"0002","name":"IJack2", "age": 2, "about": "human2"],
                ["id":"0003","name":"IJack3", "age": 3, "about": "human3"],
                ["id":"0004","name":"IJack4", "age": 4, "about": "human4"],
                ["id":"0005","name":"IJack5", "age": 5, "about": "human5"],
                ["id":"0006","name":"IJack6", "age": 6, "about": "human6"],
                ["id":"0007","name":"IJack7", "age": 7, "about": "human7"],
                ["id":"0008","name":"IJack8", "age": 8, "about": "human8"],
                ["id":"0009","name":"IJack9", "age": 9, "about": "human9"],
                ["id":"0010","name":"IJack9", "age": 9, "about": "human9"],
                ["id":"0011","name":"IJack9", "age": 9, "about": "human9"],
                ["id":"0012","name":"IJack9", "age": 9, "about": "human9"],
                ["id":"0013","name":"IJack9", "age": 9, "about": "human9"],
            ])
        
        return json
    }
    
}