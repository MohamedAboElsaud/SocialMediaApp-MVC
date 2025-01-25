//
//  PostAPI.swift
//  SocialMediaApp
//
//  Created by mohamed ahmed on 23/01/2025.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostAPI: API{
    
    static func getAllPosts(limit: Int,skip: Int,tag: String?,completionHandler: @escaping ([Post],Int) -> ()){
        
        var url = baseURL+"posts"
        if let tag = tag{
            
            url=url+"/tag/\(tag)"
        }
        let params = [
            "skip":"\(skip)",
            "limit":"\(limit)",
        ]
        print(url)
        AF.request(url,parameters: params,encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["posts"]
            let total = jsonData["total"].intValue
            let decoder = JSONDecoder()
            do{
                let posts = try decoder.decode([Post].self, from: data.rawData())
                completionHandler(posts,total)

            }catch let error{
                print(error)
            }
        }
    }
    
    static func getPostComments(postId: String, completionHandler: @escaping ([Comment])->()){
        
        let url = baseURL+"post/\(postId)/comments"
        AF.request(url).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["comments"]
            let decoder = JSONDecoder()
            do{
                let comments = try decoder.decode([Comment].self, from: data.rawData())
                completionHandler(comments)
            }catch let error{
                print(error)
            }
        }
        
    }
    
    
    static func addNewCommentToPost(message: String,postId:String,userId:String,completionHandler: @escaping (Comment?,String?)->()){
        let url = baseURL+"comments/add"
        let params = [
            "body": message,
            "postId": postId,
            "userId": userId
        ]
        AF.request(url,method: .post,parameters: params,encoder: JSONParameterEncoder.default).validate().responseJSON { response in
            
            switch response.result{
                
            case .success:
                
                let jsonData = JSON(response.value)
                let decoder = JSONDecoder()
                do{
                    let comments = try decoder.decode(Comment.self, from: jsonData.rawData())
                    completionHandler(comments,nil)
                }catch let error{
                    print(error)
                }
                
            case .failure(let error):
               print("error")
                completionHandler(nil,"error")
                
            }
        }
        
    }
    
    static func getAllTags(completionHandler: @escaping ([String]) -> ()){
         
         let url = baseURL+"posts/tag-list"
         AF.request(url).responseJSON { response in
             let jsonData = JSON(response.value)
             print(jsonData)
             let decoder = JSONDecoder()
             print(decoder)
             do{
                 let tags = try decoder.decode([String].self, from: jsonData.rawData())
                 print(tags)
                 completionHandler(tags)

             }catch let error{
                 print(error)
             }
         }
     }
}
