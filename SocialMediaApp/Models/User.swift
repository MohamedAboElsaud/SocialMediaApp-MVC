//
//  User.swift
//  SocialMediaApp
//
//  Created by mohamed ahmed on 21/01/2025.
//

import Foundation
import UIKit
struct User: Decodable{
    
    let id: Int
    var firstName: String
    var lastName: String
    var age: Int?
    var gender: String?
    var email: String?
    var username: String?
    var image: String?
    var phone: String?

    
}
