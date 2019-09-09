//
//  missionTableViewCell.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/30.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class MissionTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var missionImage: UIImageView!
    

    @IBOutlet weak var missionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        missionImage.image = UIImage(named: "")
            }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

