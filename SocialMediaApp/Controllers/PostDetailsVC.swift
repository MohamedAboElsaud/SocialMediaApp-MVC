//
//  PostDetailsVCViewController.swift
//  SocialMediaApp
//
//  Created by mohamed ahmed on 21/01/2025.
//

import UIKit
import Alamofire
import SwiftyJSON

class PostDetailsVC: UIViewController {
    
    var post: Post!
    var user: User!
    
    var imageofUser: String!
    var comments: [Comment] = []
    @IBOutlet weak var commentSV: UIStackView!
    @IBOutlet weak var commentTF: UITextField!
    @IBOutlet weak var commentsTabelView: UITableView!
    @IBOutlet weak var dislikesPostDetailsLabel: UILabel!
    @IBOutlet weak var likesPostDetailsLabel: UILabel!
    @IBOutlet weak var bodyPostDetailsLabel: UILabel!
    @IBOutlet weak var fullNameuserDetailsPostLabel: UILabel!
    @IBOutlet weak var userNameuserDetailsPostLabel: UILabel!
    @IBOutlet weak var titlePostDetailsLabel: UILabel!
    @IBOutlet weak var userImageDetailsPostImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserManager.loggedInUser == nil{
            commentSV.isHidden = true
        }
        commentsTabelView.dataSource = self
        commentsTabelView.delegate = self
        
        fullNameuserDetailsPostLabel.text = user.firstName + user.lastName
        userNameuserDetailsPostLabel.text = user.username
        
        userImageDetailsPostImageView.setImageFromStringUrl(stringUrl: imageofUser)
        dislikesPostDetailsLabel.text = String( post.reactions["dislikes"] ?? 0)
        likesPostDetailsLabel.text = String( post.reactions["likes"] ?? 0)
        titlePostDetailsLabel.text = post.title
        bodyPostDetailsLabel.text  = post.body
        
        
  getComments()
        
        // Do any additional setup after loading the view.
        
    }
    
    func getComments(){
        PostAPI.getPostComments(postId:String(post.id)) { commentsResponse in
            
            self.comments = commentsResponse
            self.commentsTabelView.reloadData()
        }
    }
    @IBAction func sendCommentButton(_ sender: Any) {
        
        let message  = commentTF.text!
        
        if let user = UserManager.loggedInUser {
            PostAPI.addNewCommentToPost(message: message, postId:String( post.id), userId: String( user.id)) { comment, error in
                if let  comment = comment{
                    
                    self.getComments()
                    print(comment.body)
                }
            }
            
        }
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
extension PostDetailsVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let comment = comments[indexPath.row]
        let commentCell  = tableView.dequeueReusableCell(withIdentifier: "CommentsCell") as! CommentsCell
        
        
        commentCell.commentMessageLabel.text = comment.body
        return commentCell
    }
    
    
}
