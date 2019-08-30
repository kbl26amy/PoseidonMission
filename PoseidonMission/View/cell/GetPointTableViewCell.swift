//
//  GetPointTableViewCell.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/30.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class GetPointTableViewCell: UITableViewCell {
    
    @IBOutlet weak var getPointImage: UIImageView!
    
    @IBOutlet weak var getPointLabel: UILabel!
    
    @IBOutlet weak var GetPointTime: UILabel!
    
    @IBOutlet weak var getPointCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
