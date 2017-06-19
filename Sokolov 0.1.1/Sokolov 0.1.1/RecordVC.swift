//
//  Post.swift
//  Sokolov 0.1.1
//
//  Created by test on 4/6/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation

class RecordVC: UIViewController
{
   
    @IBOutlet weak var head: UILabel!

    @IBOutlet weak var content: UILabel!

    @IBOutlet weak var date: UILabel!

    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var comment: UIBarButtonItem!

    @IBOutlet weak var like: UIBarButtonItem!

    @IBOutlet weak var repost: UIBarButtonItem!

    let SS = APIStubService()
    var json: JSON = []
    var idPost = ""
    var idPage = ""
    var a = ""
    override func viewDidAppear(animated: Bool) {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    override func viewDidLoad() {
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        json = SS.getPost(idPage, idPost: idPost)
        
        head.text = ParseJSON.instance.parseWithoutId(json, first: "Head")
        content.text = ParseJSON.instance.parseWithoutId(json, first: "Content")
        date.text = ParseJSON.instance.parseWithoutId(json, first: "Date")
        name.text = ParseJSON.instance.parseWithoutId(json, first: "Autor")
        
        comment.title = ParseJSON.instance.parseWithoutId(json, first: "Comment")
        like.title = "♡" + ParseJSON.instance.parseWithoutId(json, first: "Like")!
        repost.title = "⏎" + ParseJSON.instance.parseWithoutId(json, first: "Repost")!
        
        content.sizeToFit()
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination: CommentsVC = segue.destinationViewController as! CommentsVC
        destination.idPage = idPage
        destination.idPost = idPost
        
    }
}