//
//  TagsVC.swift
//  SocialMediaApp
//
//  Created by mohamed ahmed on 25/01/2025.
//

import UIKit
import NVActivityIndicatorView

class TagsVC: UIViewController {

    var tags = ["a","b","c"]
    @IBOutlet weak var activityLoader: NVActivityIndicatorView!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tagsCollectionView.dataSource = self
        tagsCollectionView.delegate = self
        activityLoader.startAnimating()
        PostAPI.getAllTags { tags in
            self.tags = tags
            self.tagsCollectionView.reloadData()
            self.activityLoader.stopAnimating()
        }
        // Do any additional setup after loading the view.
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
extension TagsVC: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        
        let currentTag = tags[indexPath.row]
        cell.tagNameLabel.text = currentTag
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        vc.tag = tag
        self.present(vc, animated: true)
    }
}
