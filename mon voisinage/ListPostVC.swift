//
//  ListPostVC.swift
//  mon voisinage
//
//  Created by Kersuzan on 31/10/2015.
//  Copyright © 2015 Kersuzan. All rights reserved.
//

import UIKit

class ListPostVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var isEditingOpened: Bool!
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func editItem(sender: UIButton!) {
        if isEditingOpened! {
            tableView.setEditing(false, animated: true)
            self.isEditingOpened = false
        } else {
            tableView.setEditing(true, animated: true)
            self.isEditingOpened = true
        }
        
        print(self.isEditingOpened)
    }
    
    var posts: [Post] = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isEditingOpened = false

        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black

        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        DataService.instance.loadPost()
        
        // Add observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onPostsLoaded:", name: "postsLoaded", object: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 135.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedPosts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = DataService.instance.loadedPosts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            cell.configureCell(post)
            return cell
            
        } else {
            let cell = PostCell()
            cell.configureCell(post)
            return cell
        }
        
        //return cell
    }
    
    // When the user select a row in the table
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let post = DataService.instance.loadedPosts[indexPath.row]
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.performSegueWithIdentifier("DetailPost", sender: post)
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            DataService.instance.deletePost(DataService.instance.loadedPosts[indexPath.row])
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailPost" {
            if let detailController = segue.destinationViewController as? DetailPostVC, let sender = sender as? Post {
                detailController.post = sender
            }
        }
    }
    
    func onPostsLoaded(item: AnyObject) {
        self.tableView.reloadData()
    }

    
}
