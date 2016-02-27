//
//  PostImageVC.swift
//  mon voisinage
//
//  Created by Kersuzan on 31/10/2015.
//  Copyright © 2015 Kersuzan. All rights reserved.
//

import UIKit

class PostImageVC: UIViewController {

    @IBOutlet weak var imageImg: UIImageView!
    
    var image: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black

        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "goBack:")
        self.imageImg.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func goBack(gestureRecognizer: UIGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        print(self.image)
        
        imageImg.image = DataService.instance.imageForPath(image)

    }
    
    
}
