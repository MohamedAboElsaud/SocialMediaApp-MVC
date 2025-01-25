//
//  ViewController.swift
//  SocialMediaApp
//
//  Created by mohamed ahmed on 21/01/2025.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
class ViewController: UIViewController {
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var LoadingActicityIndicator: NVActivityIndicatorView!
    var posts: [Post] = []
    
    var skip = 0
    var limit = 5
    var total = 0
    var userImage:UIImage?
    var tag:String?
    @IBOutlet weak var hiuserLabel: UILabel!
    
    @IBOutlet weak var postsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = UserManager.loggedInUser{
            hiuserLabel.text = "Hi,\(user.firstName)"
        }
        else{
            hiuserLabel.isHidden = true
        }
        // Do any additional setup after loading the view.
        if let tag = tag {
            tagLabel.text = tag
        }else{
            tagLabel.isHidden = true
        }
        postsTableView.dataSource = self
        postsTableView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(userProfileTapped), name: NSNotification.Name(rawValue: "userSTTapped"), object: nil)
        
        

        getPosts()
        
    }
    func getPosts(){
        LoadingActicityIndicator.startAnimating()
        
        PostAPI.getAllPosts(limit: limit ,skip: skip,tag: tag) { postsResponse,total  in
            self.posts.append(contentsOf: postsResponse)
            self.total = total
            self.postsTableView.reloadData()
            self.LoadingActicityIndicator.stopAnimating()
        }
    }
    @IBAction func logoutButton(_ sender: Any) {
        UserManager.loggedInUser = nil
        dismiss(animated: true)
    }
    @objc func userProfileTapped(notification : Notification){
        print("profile")
        if let cell = notification.userInfo?["cell"] as? UITableViewCell{
            if let index = postsTableView.indexPath(for: cell){
                let post = posts[index.row]
                
                let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as? ProfileVC
                if let vc = vc {
                    
                    UserAPI.getUserData(userId: String( post.userId)) { userresponse in
                        vc.user = userresponse
                        self.present(vc,animated: true)
                    }
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let userId = post.userId
        let postsCell = tableView.dequeueReusableCell(withIdentifier: "PostsCell") as! PostsCell
        
        UserAPI.getUserData(userId: String(userId)) { userResponse in
            
            postsCell.userFullName.text = userResponse.firstName + userResponse.lastName
            postsCell.username.text = userResponse.username
            postsCell.imageUserPost.makeCirclarImage()
            let imageurl = userResponse.image!
            postsCell.imageUserPost.setImageFromStringUrl(stringUrl: imageurl)
        }
        postsCell.titleofPostLabel.text = post.title
        postsCell.bodyofPostLabel.text = post.body
        postsCell.likesPostLabel.text = String(post.reactions["likes"] ?? 0)
        postsCell.dislikesPostLabel.text = String(post.reactions["dislikes"] ?? 0)
        postsCell.tags = post.tags!
        return postsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(identifier: "PostDetailsVC") as? PostDetailsVC
        if let vc = vc{
            
            vc.post = posts[indexPath.row]
            
            UserAPI.getUserData(userId: String(posts[indexPath.row].userId)) { userResponse in
                vc.user = userResponse
                let imageurl = userResponse.image!
                vc.imageofUser = imageurl
                
                self.present(vc, animated: true)
            }

            
            
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == posts.count - 1 && posts.count < total{
            
            skip = skip + 1
            getPosts()
        }
    }
}
