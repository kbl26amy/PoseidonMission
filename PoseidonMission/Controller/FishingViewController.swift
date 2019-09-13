//
//  FishingViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class FishingViewController: UIViewController {

    @IBOutlet weak var ship: UIImageView!
    @IBOutlet weak var fishingButton: UIButton!
    @IBOutlet weak var chanceBagroundView: UIView!
    @IBOutlet weak var fishingBackground: UIImageView!
    @IBOutlet weak var fishingRod: UIImageView!
    @IBOutlet weak var energyBar: UIImageView!
    @IBOutlet weak var leftMoveButton: UIButton!
    @IBOutlet weak var rightMoveButton: UIButton!
    @IBOutlet weak var fishingLine: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
        ship.image = UIImage(named: "ship")
        chanceBagroundView.layer.cornerRadius = 15
        fishingButton.layer.cornerRadius = 15
        fishingBackground.image = UIImage(named: "background")
        fishingRod.image = UIImage(named: "fishingRod")
        
        fishingLine.image = UIImage(named: "fishingLine")
        rightMoveButton.setImage(UIImage(named: "rightButton"), for: .normal)
        leftMoveButton.setImage(UIImage(named: "leftButton"), for: .normal)
        energyBar.layer.cornerRadius = 15
        energyBar.layer.borderWidth = 3
        energyBar.layer.borderColor = #colorLiteral(red: 0.1359939873, green: 0.3958500326, blue: 0.4860774279, alpha: 1)
  
    }
    

}
