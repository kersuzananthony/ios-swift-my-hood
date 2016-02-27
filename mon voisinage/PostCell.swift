//
//  postCell.swift
//  mon voisinage
//
//  Created by Kersuzan on 31/10/2015.
//  Copyright © 2015 Kersuzan. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.postImg.layer.cornerRadius = self.postImg.frame.width / 2
        self.postImg.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        titleLbl.text = post.postTitle
        descriptionLbl.text = post.postDescription
        postImg.image = DataService.instance.imageForPath(post.postImage)
    }
    

}
