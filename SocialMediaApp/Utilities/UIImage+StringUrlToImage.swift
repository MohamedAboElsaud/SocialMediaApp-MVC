//
//  UIImage+StringUrlToImage.swift
//  SocialMediaApp
//
//  Created by mohamed ahmed on 22/01/2025.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImageFromStringUrl(stringUrl : String ){
        
        if let url = URL(string: stringUrl ){
            if let imageData = try? Data(contentsOf: url){
                self.image = UIImage(data: imageData)
            }
        }
    }
    
    func makeCirclarImage(){
        self.layer.cornerRadius = self.frame.width / 2
    }
}
