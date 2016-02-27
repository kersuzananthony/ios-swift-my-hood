//
//  DetailPostVC.swift
//  mon voisinage
//
//  Created by Kersuzan on 31/10/2015.
//  Copyright © 2015 Kersuzan. All rights reserved.
//

import UIKit

class DetailPostVC: UIViewController {
    
    var post: Post!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
        self.image.layer.cornerRadius = self.image.frame.width / 2
        self.image.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "openPicture:")
        
        self.image.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func openPicture(event: UIGestureRecognizer) {
        self.performSegueWithIdentifier("PostImage", sender: post)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let postImageController = segue.destinationViewController as? PostImageVC, let post = sender as? Post {
            postImageController.image = post.postImage
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.title = post.postTitle
        
        titleLbl.text = post.postTitle
        descriptionLbl.text = post.postDescription
        image.image = DataService.instance.imageForPath(post.postImage)
    }
    

}
