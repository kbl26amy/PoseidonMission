//
//  JellyfishViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class JellyfishViewController: UIViewController {

    @IBOutlet weak var jellyBackGroundView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        jellyBackGroundView.image = UIImage(named: "jellyfishbackground")
    }
    


}
