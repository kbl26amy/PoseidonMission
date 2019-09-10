//
//  LoginTodayViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class LoginTodayViewController: UIViewController {

    
    @IBAction func closeLoginToday(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var leftUpBlueView: UIView!
    
    @IBOutlet weak var rightDownView: UIView!
    @IBOutlet weak var leftDownView: UIView!
    @IBOutlet weak var rightUpBlueView: UIView!
    @IBOutlet weak var loginTodayView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        loginTodayView.layer.cornerRadius = 20
        leftUpBlueView.layer.cornerRadius = 5
        rightUpBlueView.layer.cornerRadius = 5
        rightDownView.layer.cornerRadius = 5
        leftDownView.layer.cornerRadius = 5
    }

}
