//
//  StoryViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/30.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var storyTextLabel: UILabel!
    @IBOutlet weak var chalengeButtonLayout: UIButton!
    @IBOutlet weak var backImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backImage.layer.cornerRadius = 15
        chalengeButtonLayout.layer.cornerRadius = 20
        navigationController?.isNavigationBarHidden = true
        backgroundImage.image = UIImage(named: "background")
        storyTextLabel.adjustsFontSizeToFitWidth = true
        targetLabel.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func leaveButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    

}
