//
//  CommentList.swift
//  Sokolov 0.1.1
//
//  Created by test on 5/2/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation

class  CommentsVC : UITableViewController {
    
    let SS = APIStubService()
    var json : JSON = []
    var idPage = ""
    var idPost = ""
    
    
    override func viewDidLoad() {
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        json = SS.getComments(idPage, idPost: idPost)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        
    }
    override func viewDidAppear(animated: Bool) {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CCForComments
     
        cell.Content.text = ParseJSON.instance.parseWithId(json, id: indexPath.row, first: "Content")
        
        cell.Date.text = ParseJSON.instance.parseWithId(json, id: indexPath.row, first: "Date")
        
        
        let title = "♡" + ParseJSON.instance.parseWithId(json, id: indexPath.row, first: "Like")!
        
        cell.LikeButton.setTitle(title, forState: .Normal)
        
        
        
        
     return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! CCForComments
        
        if cell.Content.numberOfLines == 0 {
            cell.Content.numberOfLines = 8
            tableView.reloadData()
        }
        else {
            cell.Content.numberOfLines = 0
            tableView.reloadData()
        }
        
    }
   
    
    
}