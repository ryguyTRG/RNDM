//
//  UpdateCommentVC.swift
//  RNDM
//
//  Created by Ryan Gjoraas on 9/30/18.
//  Copyright © 2018 Developed by Gjoraas. All rights reserved.
//

import UIKit
import Firebase

class UpdateCommentVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var updateButton: UIButton!
    
    // Variables
    var commentData: (comment: Comment, thought: Thought)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentText.layer.cornerRadius = 10
        updateButton.layer.cornerRadius = 10
        commentText.text = commentData.comment.commentTxt

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func updateTapped(_ sender: Any) {
        Firestore.firestore().collection(THOUGHTS_REF).document(commentData.thought.documentID)
            .collection(COMMENTS_REF).document(commentData.comment.documentId).updateData([COMMENT_TXT : commentText.text]) { (error) in
                if let error = error {
                    debugPrint("unable to update comment: \(error.localizedDescription)")
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
                
        }
    }
    
    
    

}
