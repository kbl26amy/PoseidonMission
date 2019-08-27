//
//  ViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/26.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class LobbyViewController: PMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "首頁"
        if var textAttributes = navigationController?.navigationBar.titleTextAttributes {
            textAttributes[NSAttributedString.Key.foregroundColor] = UIColor.red
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        }
    }


}

