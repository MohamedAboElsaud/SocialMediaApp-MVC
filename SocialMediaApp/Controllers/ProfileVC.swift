//
//  ProfileVC.swift
//  SocialMediaApp
//
//  Created by mohamed ahmed on 23/01/2025.
//

import UIKit
import Foundation

class ProfileVC: UIViewController {

    @IBOutlet weak var profilePhone: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var profileGender: UILabel!
    @IBOutlet weak var profileUsername: UILabel!
    @IBOutlet weak var profileFullName: UILabel!
    @IBOutlet weak var profileAge: UILabel!
    @IBOutlet weak var profileUserPicture: UIImageView!
    var user:User!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        profileUserPicture.setImageFromStringUrl(stringUrl: user.image!)
        profileUserPicture.makeCirclarImage()
        profilePhone.text = user.phone
        profileEmail.text = user.email
        profileGender.text = user.gender
        profileUsername.text = user.username
        profileAge.text = "\(user.age ?? 0)"
        profileFullName.text = user.firstName + user.lastName

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
