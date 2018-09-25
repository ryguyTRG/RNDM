//
//  thoughtCell.swift
//  RNDM
//
//  Created by Ryan Gjoraas on 9/20/18.
//  Copyright © 2018 Developed by Gjoraas. All rights reserved.
//

import UIKit
import Firebase

protocol ThoughtDelegate {
    func thoughtOptionsTapped(thought: Thought)
}

class thoughtCell: UITableViewCell {
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var thoughtTxtLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var likesNumLabel: UILabel!
    @IBOutlet weak var commentsNumLabel: UILabel!
    @IBOutlet weak var optionsMenu: UIImageView!
    // Variables
    
    private var thought: Thought!
    private var delegate: ThoughtDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likesImage.addGestureRecognizer(tap)
        likesImage.isUserInteractionEnabled = true
    }
    
    @objc func likeTapped() {
        Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentID)
            .setData([NUM_LIKES : thought.numLikes + 1], options: SetOptions.merge())
        
    }

    func configureCell (thought: Thought, delegate: ThoughtDelegate?) {
        optionsMenu.isHidden = true
        
        self.thought = thought
        self.delegate = delegate
        
        userNameLabel.text = thought.username
        thoughtTxtLabel.text = thought.thoughtTxt
        likesNumLabel.text = String(thought.numLikes)
        commentsNumLabel.text = String(thought.numComments)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: thought.timestamp)
        timestampLabel.text = timestamp
        
        if thought.userId == Auth.auth().currentUser?.uid {
            optionsMenu.isHidden = false
            optionsMenu.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(thoughtOptionsTapped))
            optionsMenu.addGestureRecognizer(tap)
        }
    }
    
    @objc func thoughtOptionsTapped() {
        delegate?.thoughtOptionsTapped(thought: thought)
        
    }
    
    
}
