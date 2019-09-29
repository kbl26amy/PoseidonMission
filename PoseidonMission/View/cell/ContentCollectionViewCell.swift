//
//  ContentCollectionViewCell.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/19.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
   
    var likeClosure: ((ContentCollectionViewCell) -> ())?
    @IBOutlet weak var rankNumber: UILabel!
    @IBOutlet weak var clickGoodButton: UIButton!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBAction func clickLikeAction(_ sender: ContentCollectionViewCell) {
        isLikedUser = !isLikedUser
        likeClosure?(sender)
        
    }
    
    var isLikedUser: Bool = false
    {
        didSet {
            switch isLikedUser {
            case true:
                let image = UIImage(named: "clickGood")
                clickGoodButton.setImage(image, for: .normal)


            case false:
                let image = UIImage(named: "unClickGood")
                clickGoodButton.setImage(image, for: .normal)
            }
        }
    }
    
    
}
