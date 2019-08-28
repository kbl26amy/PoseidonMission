//
//  MapViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapBackground: UIImageView!
    
    @IBOutlet weak var mapTitleLabel: UILabel!
    
    @IBOutlet weak var mapchanceLabel: UILabel!
    
    @IBOutlet weak var baseMapImage: UIImageView!
    
    @IBOutlet weak var seeRecordButton: UIButton!
    
    @IBOutlet weak var seeRuleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapBackground.image = UIImage(named: "mapbackground")
        
        self.baseMapImage.image = UIImage(named: "showmap")
        
        self.seeRuleButton.setImage(UIImage(named: "redbutton"), for: .normal)
        
         self.seeRecordButton.setImage(UIImage(named: "orangebutton"), for: .normal)
    }
    


}
