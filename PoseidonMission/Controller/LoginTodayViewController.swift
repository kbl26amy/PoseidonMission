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
    @IBOutlet weak var loginTodayView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

       loginTodayView.layer.cornerRadius = 20
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
