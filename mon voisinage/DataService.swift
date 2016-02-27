//
//  DataService.swift
//  mon voisinage
//
//  Created by Kersuzan on 31/10/2015.
//  Copyright © 2015 Kersuzan. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    
    static let instance = DataService()
    
    let OBJECT_KEY = "posts"
    
    private var _loadedPosts: [Post] = [Post]()
    
    var loadedPosts: [Post] {
        return self._loadedPosts
    }
    
    func savePost() {
        // Save all the posts in the NSUserDefault
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(self._loadedPosts)
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: OBJECT_KEY)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func loadPost() {
        // Load the post in the NSUserDefault
        if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(OBJECT_KEY) as? NSData {
            if let posts = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post] {
                self._loadedPosts =  posts
            }
        }
        
        // send a notification for other controller
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
    }
    
    func addPost(post: Post) {
        self._loadedPosts.append(post)
        self.savePost()
        self.loadPost()
    }
    
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPathForFilename(path)
        let image = UIImage(named: fullPath)
        return image
    }
    
    func saveImageAndCreatePath(image: UIImage) -> String {
        
        let imageData = UIImagePNGRepresentation(image)
        let imagePath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        let fullPath = documentsPathForFilename(imagePath)
        imageData?.writeToFile(fullPath, atomically: true)
        return imagePath
        
    }
    
    func documentsPathForFilename(filename: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let fullPath = paths[0] as NSString
        return fullPath.stringByAppendingPathComponent(filename)
    }
    
    func deletePost(post: Post) {
        
        if let index = self._loadedPosts.indexOf(post) {
            self._loadedPosts.removeAtIndex(index)
            self.savePost()
            self.loadPost()
        }
        
        
    }
    
    
}