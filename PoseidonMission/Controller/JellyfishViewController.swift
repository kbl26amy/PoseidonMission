//
//  JellyfishViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class JellyfishViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var jellyBackGroundView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
navigationController?.isNavigationBarHidden = true
        jellyBackGroundView.image = UIImage(named: "jellyfishbackground")
        var supportedInterfaceOrientations: UIInterfaceOrientationMask{
            return .landscape
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appDelegate.interfaceOrientations = [.landscapeLeft, .landscapeRight]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
 
        appDelegate.interfaceOrientations = .portrait
    }

    
    

}
