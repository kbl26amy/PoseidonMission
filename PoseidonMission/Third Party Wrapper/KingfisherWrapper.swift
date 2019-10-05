//
//  KingfisherWrapper.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/10/5.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func loadImage(_ urlString: String?, placeHolder: UIImage? = nil) {

        guard urlString != nil else { return }
        
        let url = URL(string: urlString!)

        self.kf.setImage(with: url, placeholder: placeHolder)
    }
}
