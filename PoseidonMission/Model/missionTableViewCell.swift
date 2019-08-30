//
//  missionTableViewCell.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/30.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class missionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var missionBannerImage: UIImageView!
    
    @IBOutlet weak var missionTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

