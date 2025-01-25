//
//  Post.swift
//  SocialMediaApp
//
//  Created by mohamed ahmed on 21/01/2025.
//

import Foundation
import UIKit
struct Post: Decodable{
    let id: Int
    let title: String
    let body: String
    let tags: [String]?
    let reactions:[String:Int]
    let views: Int
    let userId: Int
}
