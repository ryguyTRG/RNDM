//
//  AddThoughtVC.swift
//  RNDM
//
//  Created by Ryan Gjoraas on 9/17/18.
//  Copyright © 2018 Developed by Gjoraas. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController, UITextViewDelegate {
    
    // Outlets
    
    @IBOutlet private weak var categorySegment: UISegmentedControl!
    @IBOutlet private weak var userNameTxt: UITextField!
    @IBOutlet private weak var thoughtTxt: UITextView!
    @IBOutlet private weak var postBtn: UIButton!
    
    // Variables
    
    private var selecteCategory = ThoughtCategory.funny.rawValue
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postBtn.layer.cornerRadius = 4
        thoughtTxt.layer.cornerRadius = 4
        thoughtTxt.text = "My Random thought..."
        thoughtTxt.textColor = UIColor.lightGray
        thoughtTxt.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.darkGray
    }
    
    
    @IBAction func postBtnTapped(_ sender: Any) {
        guard let userName = userNameTxt.text else { return }
        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data:
            [ CATEGORY: selecteCategory,
              NUM_COMMENTS : 0,
              NUM_LIKES : 0,
              THOUGHT_TXT : thoughtTxt.text,
              TIMESTAMP : FieldValue.serverTimestamp(),
              USERNAME : userName,
              USER_ID: Auth.auth().currentUser?.uid ?? ""
            ])
        { (err) in
            if let error = err {
                debugPrint("Error adding document: \(error)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selecteCategory = ThoughtCategory.funny.rawValue
        case 1:
            selecteCategory = ThoughtCategory.serious.rawValue
        default:
            selecteCategory = ThoughtCategory.crazy.rawValue
        }
        
    }
    
    
    


}
