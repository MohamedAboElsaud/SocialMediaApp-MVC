//
//  PostsCell.swift
//  SocialMediaApp
//
//  Created by mohamed ahmed on 21/01/2025.
//

import UIKit

class PostsCell: UITableViewCell {

    var user:User!
    var post:Post!
    var tags:[String] = []
    @IBOutlet weak var dislikesPostLabel: UILabel!
    @IBOutlet weak var likesPostLabel: UILabel!
//    @IBOutlet weak var backView: UIView!{
//        didSet{
//            backView.layer.shadowColor = UIColor.gray.cgColor
//            backView.layer.shadowOpacity = 0.3
//            backView.layer.shadowOffset = CGSize(width: 6, height: 6)
//            backView.layer.shadowRadius = 6
//            backView.layer.cornerRadius = 10
//        }
//    }
    @IBOutlet weak var profileStackClicked: UIStackView!{
        didSet{
            profileStackClicked.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userSVTapped)))
        }
    }
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!{
        didSet{
            tagsCollectionView.delegate = self
            tagsCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var bodyofPostLabel: UILabel!
    @IBOutlet weak var titleofPostLabel: UILabel!
    @IBOutlet weak var imageUserPost: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userFullName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func userSVTapped(){
        print("userTapped")
        NotificationCenter.default.post(name: NSNotification.Name("userSTTapped"), object: nil,userInfo: ["cell" : self])
    }

}
extension PostsCell: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostTagsCell", for: indexPath) as! PostTagsCell
        cell.tagNameLabel.text = tags[indexPath.row]
        
        
        return cell
    }
    
    
}
