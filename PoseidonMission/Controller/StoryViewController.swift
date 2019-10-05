//
//  StoryViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/30.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class StoryViewController: PMBaseViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var storyTextLabel: UILabel!
    @IBOutlet weak var chalengeButtonLayout: UIButton!
    @IBOutlet weak var backImage: UIImageView!
    
    var targetText: String = ""
    var storyText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backImage.layer.cornerRadius = 10
        chalengeButtonLayout.layer.cornerRadius = 15
        navigationController?.isNavigationBarHidden = true
        backgroundImage.image = UIImage.asset(.background)
        storyTextLabel.adjustsFontSizeToFitWidth = true
        targetLabel.adjustsFontSizeToFitWidth = true
        targetLabel.text = targetText
        storyTextLabel.text = storyText
    }
    
    @IBAction func leaveButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func goToChallenge(_ sender: Any) {
        
        var goToMissionViewController = UIViewController()
    
        switch targetLabel.text {
            
        case StoryContent.mapTarget:
            goToMissionViewController =  UIStoryboard.mission.instantiateViewController(withIdentifier: "MapViewController")
           
        case StoryContent.jellyFishTarget:
            goToMissionViewController =  UIStoryboard.mission.instantiateViewController(withIdentifier: "JellyfishViewController")
            
        case StoryContent.fishingTarget:
            goToMissionViewController =  UIStoryboard.mission.instantiateViewController(withIdentifier: "FishingViewController")
            
        default:
            goToMissionViewController =  UIStoryboard.mission.instantiateViewController(withIdentifier: "MissionViewController")
        }
        self.navigationController?.pushViewController(goToMissionViewController, animated: true)
        
       
    }
    

}
