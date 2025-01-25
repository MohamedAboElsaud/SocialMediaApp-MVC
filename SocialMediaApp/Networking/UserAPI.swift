//
//  UserAPI.swift
//  SocialMediaApp
//
//  Created by mohamed ahmed on 23/01/2025.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserAPI: API{
    
    static func getUserData(userId: String,completionHandler: @escaping (User)->()){
        let url = baseURL+"user/\(userId)"
        AF.request(url).responseJSON { response in
            let jsonData = JSON(response.value)
            let decoder = JSONDecoder()
            do{
                let user = try decoder.decode(User.self, from: jsonData.rawData())
                completionHandler(user)
            }catch let error{
                print(error)
            }
        }
    }
    
    static func registerNewUser(FName: String,LName: String,Email: String,completionHandler: @escaping (User?,String?)->()){
        let url = baseURL+"users/add"
        let params = [
            "firstName": FName,
            "lastName": LName,
            "email": Email
        ]
        AF.request(url,method: .post,parameters: params,encoder: JSONParameterEncoder.default).validate().responseJSON { response in
            
            switch response.result{
                
            case .success:
                let jsonData = JSON(response.value)
                let decoder = JSONDecoder()
                do{
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    completionHandler(user,nil)
                }catch let error{
                    print(error)
                }
                
            case .failure(let error):
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                let emailUsed = data["email"].stringValue
                let firstname = data["firstname"].stringValue
                let lastname = data["lastname"].stringValue
                let error = firstname + lastname + emailUsed
                completionHandler(nil,error)
                
                
            }
        }
        
    }
    
    static func signInUser(username: String,password: String,completionHandler: @escaping (User?,String?)->()){
        let url = baseURL+"user/login"
        let params = [
            "username": username,
            "password": password
        ]
        AF.request(url,method: .post,parameters: params,encoder: JSONParameterEncoder.default).validate().responseJSON { response in
            
            switch response.result{
                
            case .success:
                let jsonData = JSON(response.value)
                let decoder = JSONDecoder()
                do{
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    completionHandler(user,nil)
                }catch let error{
                    print(error)
                }
                
            case .failure(let error):
                let jsonData = JSON(response.data)
                let data = jsonData["message"].stringValue
                let error = data
                completionHandler(nil,error)
                
                
            }
        }
        
    }
    static func updateUserInfo(userId:Int,user: User,completionHandler: @escaping (User?,String?)->()){
        let url = baseURL+"user/\(userId)"
        let params = [
            "firstName": user.firstName,
            "gender": user.gender
        ]
        AF.request(url,method: .put,parameters: params,encoder: JSONParameterEncoder.default).validate().responseJSON { response in
            
            switch response.result{
                
            case .success:
                let jsonData = JSON(response.value)
                let decoder = JSONDecoder()
                do{
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    completionHandler(user,nil)
                }catch let error{
                    print(error)
                }
                
            case .failure(let error):
                let jsonData = JSON(response.data)
                let data = jsonData["message"].stringValue
                let error = data
                completionHandler(nil,error)
                
                
            }
        }
        
    }
    
}
