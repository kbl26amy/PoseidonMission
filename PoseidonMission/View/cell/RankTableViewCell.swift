//
//  RankTableViewCell.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/9.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class RankTableViewCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var userRecord: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
