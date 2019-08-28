//
//  AuthViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/28.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class AuthViewController: PMBaseViewController {

    @IBOutlet weak var treasureView: UIImageView!
    
    @IBOutlet weak var registerButtonLayout: UIButton!
    
    @IBOutlet weak var cancelRegister: UIButton!
    
    @IBAction func cancelRegisterAction(_ sender: Any) {
        
        presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func appleLogin(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
       treasureView.isHidden = true
        registerButtonLayout.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2, animations: { [weak self] in
            
            self?.treasureView.isHidden = false
            self?.registerButtonLayout.isHidden = false
        })
    }
       
    }
    



