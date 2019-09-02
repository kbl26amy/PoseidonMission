//
//  AuthViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/28.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

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
    
    var userNameView = UIImageView()
    var userNameTextfield = UITextField()
    
    @IBAction func showRegisterButtonView(_ sender: UIButton) {
        if userNameTextfield.text == ""{
            setRegisterView()
        }else {
            createAccountAction(self)
        }
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        loginAction(self)
    }
    
    @IBAction func cancelRegisterAction(_ sender: Any) {
        
        print("cancel")
        self.navigationController?.popViewController(animated: true)
        
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        treasureView.isHidden = true
        navigationController?.isNavigationBarHidden = true
        setLoginView()
        
        emailTextField.placeholder = "Email Adress"
        passwordTextField.placeholder = "Password"
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        UIView.animate(withDuration: 2, animations: { [weak self] in
            
            self?.treasureView.isHidden = false
        
        })
    }
    
    func setLoginView(){
        self.authBackgroundImage.image = UIImage(named: "background")
        self.treasureView.image = UIImage(named: "treasure")
        self.registerButtonLayout.setImage(UIImage(named: "register"), for: .normal)
        self.emailBackImage.image = UIImage(named: "account")
        self.passwordBackImage.image = UIImage(named: "password")
        self.loginButton.setImage(UIImage(named: "login"), for: .normal)
        self.loginButton.imageView?.contentMode = .scaleAspectFit
        self.registerButtonLayout.imageView?.contentMode = .scaleAspectFit
    }
    
    func setRegisterView(){
        self.loginButton.isHidden = true
        
        self.userNameView = UIImageView(frame: CGRect(x: self.loginButton.frame.origin.x, y: self.loginButton.frame.origin.y, width: self.treasureView.frame.width * 5/7, height: self.treasureView.frame.height * 1/7)
            )
        
        self.userNameView.image = UIImage(named:"password")
        self.userNameView.center.x =  self.treasureView.center.x
        view.addSubview(self.userNameView)
        self.userNameTextfield = UITextField(frame: CGRect(
            x: self.passwordTextField.frame.origin.x,
            y: self.userNameView.frame.origin.y,
            width: self.userNameView.frame.width * 5/7,
            height: self.userNameView.frame.height))
        
        self.userNameTextfield.textColor = UIColor(red: 58/255, green: 88/255, blue: 152/255, alpha: 1)
        self.userNameTextfield.font = UIFont(name:self.userNameTextfield.font!.fontName
            , size: 14)
        self.userNameTextfield.placeholder = "User Name"
        view.addSubview(self.userNameTextfield)
     
    }
    
    func createAccountAction(_ sender: AnyObject) {
        
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    print("successfully signed up")
                    let db = Firestore.firestore()
                   
                    
                    let data: [String: Any] = ["userName": self.userNameTextfield.text!,"email": self.emailTextField.text! ]
                    db.collection("user").document((Auth.auth().currentUser?.uid)!).setData(data){ (error) in
                        if let error = error {
                            print(error)
                        }else {
                            print(Auth.auth().currentUser?.uid as Any)
                        }
                    }
                    
                    self.navigationController?.popViewController(animated: true)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    func loginAction(_ sender: AnyObject) {
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            let reference: DocumentReference? = nil
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    self.navigationController?.popViewController(animated: true)
                
                } else {
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

}


