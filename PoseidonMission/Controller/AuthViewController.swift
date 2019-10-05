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
import AuthenticationServices

class AuthViewController: PMBaseViewController {
    @IBOutlet weak var versionLabel: UILabel!
    
    var userNameView = UIImageView()
    var userNameTextfield = UITextField()
    
    @IBOutlet weak var authBackgroundImage: UIImageView!
    @IBOutlet weak var treasureView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButtonLayout: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cancelRegister: UIButton!
    @IBOutlet weak var emailBackImage: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordBackImage: UIImageView!
    @IBOutlet weak var goBackButton: UIButton!
    
    @IBAction func goBackToLogin(_ sender: Any) {
        self.userNameView.isHidden = true
        self.userNameTextfield.isHidden = true
        self.loginButton.isHidden = false
        self.goBackButton.isHidden = true
    }
    
    func appVersion() {
        let infoDictionary = Bundle.main.infoDictionary
        
        let majorVersion :String? = infoDictionary? ["CFBundleShortVersionString"] as? String

        let minorVersion :String? = infoDictionary? ["CFBundleVersion"] as? String 

        let appversion = (majorVersion ?? "") + (minorVersion ?? "")
        self.versionLabel.text = "版本號：\(appversion)"
    }
    func showAppleSignIn() {
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.addTarget(self,
                              action: #selector(didTapAppleButton),
                              for: .touchUpInside)
        view.addSubview(appleButton)
        view.layoutIfNeeded()
        NSLayoutConstraint.activate([
            appleButton.centerXAnchor.constraint(equalTo: self.registerButtonLayout.centerXAnchor),
            appleButton.topAnchor.constraint(equalTo: self.registerButtonLayout.bottomAnchor, constant: 10),
            appleButton.widthAnchor.constraint(equalToConstant: self.registerButtonLayout.frame.width * 5/7)
        ])
    }
    
    @objc func didTapAppleButton() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(
            authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
    }
    @IBAction func showRegisterButtonView(_ sender: UIButton) {
        
        if loginButton.isHidden == false {
            
            setRegisterView()
            
        }else {
            
            createAccountAction(self)
        }
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
        loginAction(self)
    }
    
    @IBAction func cancelRegisterAction(_ sender: Any) {
    
        self.backToRoot()
        
    }
    
    @IBAction func privacyButton(_ sender: Any) {
        
        let urlString = "https://www.privacypolicies.com/privacy/view/9365f69ef7a7434aeed4d5f09ca3f683"
        let url = URL(string: urlString)
        UIApplication.shared.open(url!,
                                  options: [:],
                                  completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goBackButton.isHidden = true
        treasureView.isHidden = true
        navigationController?.isNavigationBarHidden = true
        setLoginView()
        showAppleSignIn()
        emailTextField.placeholder = "Email Adress"
        passwordTextField.placeholder = "Password"
        appVersion()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2, animations: { [weak self] in
            
            self?.treasureView.isHidden = false
            
        })
    }
    
    func setLoginView(){
        self.authBackgroundImage.image = UIImage.asset(.background)
        self.treasureView.image = UIImage.asset(.treasure)
        self.registerButtonLayout.setImage(UIImage.asset(.register), for: .normal)
        self.emailBackImage.image = UIImage.asset(.account)
        self.passwordBackImage.image = UIImage.asset(.password)
        self.loginButton.setImage(UIImage.asset(.login), for: .normal)
        self.loginButton.imageView?.contentMode = .scaleAspectFit
        self.registerButtonLayout.imageView?.contentMode = .scaleAspectFit
    }
    
    func setRegisterView(){
        self.loginButton.isHidden = true
        self.goBackButton.isHidden = false
        
        self.userNameView = UIImageView(frame:
            CGRect(x: self.loginButton.frame.origin.x,
                   y: self.loginButton.frame.origin.y,
                   width: self.treasureView.frame.width * 5/7,
                   height: self.treasureView.frame.height * 1/7)
        )
        
        self.userNameView.image = UIImage.asset(.account)
        
        self.userNameView.center.x =  self.treasureView.center.x
        view.addSubview(self.userNameView)
        
        self.userNameTextfield = UITextField(frame: CGRect(
            x: self.passwordTextField.frame.origin.x,
            y: self.userNameView.frame.origin.y,
            width: self.userNameView.frame.width * 5/7,
            height: self.userNameView.frame.height))
        
        self.userNameTextfield.textColor = UIColor(red: 58/255,
                                                   green: 88/255,
                                                   blue: 152/255,
                                                   alpha: 1)
        
        self.userNameTextfield.font = UIFont(name:self
            .userNameTextfield.font!.fontName, size: 14)
        
        self.userNameTextfield.placeholder = "User Name"
        
        view.addSubview(self.userNameTextfield)
        userNameTextfield.delegate = self
    }
    
    func createAccountAction(_ sender: AnyObject) {
        
        if emailTextField.text == "" ||
            userNameTextfield.text == "" ||
            passwordTextField.text == "" {
            
            UIAlertController.showAlert(message: "請填入完整資訊")
            
        } else {
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    print("successfully signed up")
                    
                    KeyChainManager.shared.set(Auth.auth().currentUser!.uid,
                                               forKey: "userid")
                    KeyChainManager.shared.set(self.emailTextField.text!,
                                               forKey: "useremail")
                    
                    let data: [String: Any] = ["userName": self.userNameTextfield.text!,
                                               "email": self.emailTextField.text! ]
                    
                    FireBaseHelper.saveData(saveData: data)
                    
                    self.backToRoot()
                    
                } else {
                    
                    UIAlertController.showAlert(message: error!.localizedDescription)
                }
            }
        }
    }
    
    
    func loginAction(_ sender: AnyObject) {
        
        if self.emailTextField.text == "" ||
            self.passwordTextField.text == "" {
            
            UIAlertController.showAlert(message:
                "Please enter an email and password.")
            
        } else {
            
            Auth.auth().signIn(withEmail: self.emailTextField.text!,
                               password: self.passwordTextField.text!)
            { (user, error) in
                if error == nil {
                    KeyChainManager.shared.set(Auth.auth().currentUser!.uid,
                                               forKey: "userid")
                    KeyChainManager.shared.set(self.emailTextField.text!,
                                               forKey: "useremail")
                    
                    UserManager.shared.getUserData(completion: {user in
                        
                        if user?.totalScore != nil {
                            UserManager.totalScore = user!.totalScore!
                        }
                        
                        if user?.loginCounts != nil {
                            UserManager.loginCounts = user!.loginCounts!
                        }
                    })
                    
                    self.backToRoot()
                    
                } else {
                    
                    UIAlertController.showAlert(message: error!.localizedDescription)
                    
                }
            }
        }
    }
    
}

extension AuthViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
            
        case let credentials as ASAuthorizationAppleIDCredential:
            let user = AppleUser(credentials: credentials)
            print(user)
            
            if KeyChainManager.shared.get("userid") == nil {
                KeyChainManager.shared.set(user.id, forKey: "userid")
                KeyChainManager.shared.set(user.id, forKey: "useremail")
            }
            if user.email != "" {
                let loginRecord = ["email":user.email,
                                   "userName": user.lastName + user.firstName]
                    as [String : Any]
                
                FireBaseHelper.saveData(saveData: loginRecord)
               
                self.backToRoot()
                
            } else {
                backToRoot()
            }
        default: break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        
        print("something bad happened", error)
    }
}

extension AuthViewController:
ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller:
        ASAuthorizationController) -> ASPresentationAnchor {
        
        return view.window!
    }
    
}

extension AuthViewController: UITextFieldDelegate,
UITextViewDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let countOfWords =
            string.count +
            textField.text!.count -
            range.length
        
        if countOfWords > 6 {
             
            UIAlertController.showAlert(message: "用戶名稱須低於六個字！")
            return false
        }
        
        return true
    }
}

