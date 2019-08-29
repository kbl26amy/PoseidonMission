//
//  AuthViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/28.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class AuthViewController: PMBaseViewController {

    @IBOutlet weak var authBackgroundImage: UIImageView!
    @IBOutlet weak var treasureView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButtonLayout: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cancelRegister: UIButton!
    
    @IBOutlet weak var emailBackImage: UIImageView!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordBackImage: UIImageView!
    @IBAction func cancelRegisterAction(_ sender: Any) {
        
        presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func appleLogin(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       navigationController?.isNavigationBarHidden = true
       treasureView.isHidden = true
      
        self.authBackgroundImage.image = UIImage(named: "background")
        self.treasureView.image = UIImage(named: "treasure")
        self.registerButtonLayout.setImage(UIImage(named: "register"), for: .normal)
        self.emailBackImage.image = UIImage(named: "account")
        self.passwordBackImage.image = UIImage(named: "password")
        self.loginButton.setImage(UIImage(named: "login"), for: .normal)
        self.loginButton.imageView?.contentMode = .scaleAspectFit
        self.registerButtonLayout.imageView?.contentMode = .scaleAspectFit
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2, animations: { [weak self] in
            
            self?.treasureView.isHidden = false
        
        })
    }
       
    }
    



