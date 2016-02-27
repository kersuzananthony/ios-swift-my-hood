//
//  Post.swift
//  mon voisinage
//
//  Created by Kersuzan on 31/10/2015.
//  Copyright © 2015 Kersuzan. All rights reserved.
//

import Foundation

class Post: NSObject, NSCoding {
    
    private var _postTitle: String!
    private var _postDescription: String!
    private var _postImage: String!
    
    var postTitle: String {
        return self._postTitle
    }
    
    var postDescription: String {
        get {
            return self._postDescription
        }
    }
    
    var postImage: String {
        get {
            return self._postImage
        }
    }
    
    override init() {
        
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        self._postTitle = aDecoder.decodeObjectForKey("postTitle") as? String
        self._postDescription = aDecoder.decodeObjectForKey("postDescription") as? String
        self._postImage = aDecoder.decodeObjectForKey("postImage") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._postTitle, forKey: "postTitle")
        aCoder.encodeObject(self._postDescription, forKey: "postDescription")
        aCoder.encodeObject(self._postImage, forKey: "postImage")
    }
    
    init(title: String, description: String, image: String) {
        self._postTitle = title
        self._postDescription = description
        self._postImage = image
    }
    
//    override init() {
//        
//    }

    
    
}