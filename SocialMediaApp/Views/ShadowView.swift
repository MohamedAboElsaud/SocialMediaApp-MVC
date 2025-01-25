//
//  ShadowView.swift
//  SocialMediaApp
//
//  Created by mohamed ahmed on 22/01/2025.
//

import UIKit

class ShadowView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShadow()
    }
    
    
    func setupShadow(){
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 6, height: 6)
        self.layer.shadowRadius = 6
        self.layer.cornerRadius = 10
    }

}
