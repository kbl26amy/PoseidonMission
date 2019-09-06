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
        self.backImage.layer.cornerRadius = 15
        chalengeButtonLayout.layer.cornerRadius = 20
        navigationController?.isNavigationBarHidden = true
        backgroundImage.image = UIImage(named: "background")
        storyTextLabel.adjustsFontSizeToFitWidth = true
        targetLabel.adjustsFontSizeToFitWidth = true
        targetLabel.text = targetText
        storyTextLabel.text = storyText
    }
    
    @IBAction func leaveButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func goToChallenge(_ sender: Any) {
    
        switch targetLabel.text {
        case StoryContent.mapTarget:
            let goToMissionViewController =  UIStoryboard.mission.instantiateViewController(withIdentifier: "MapViewController")
            self.navigationController?.pushViewController(goToMissionViewController, animated: true)
            
            case StoryContent.jellyFishTarget:
                let goToMissionViewController =  UIStoryboard.mission.instantiateViewController(withIdentifier: "JellyfishViewController")
                self.navigationController?.pushViewController(goToMissionViewController, animated: true)
        default:
            let goToMissionViewController =  UIStoryboard.mission.instantiateViewController(withIdentifier: "MissionController")
            self.navigationController?.pushViewController(goToMissionViewController, animated: true)
        }
        
       
    }
    

}
