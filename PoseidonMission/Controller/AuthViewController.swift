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
    
    func showAppleSignIn() {
        let appleButton = ASAuthorizationAppleIDButton()
    appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        view.addSubview(appleButton)
        view.layoutIfNeeded()
        NSLayoutConstraint.activate([
        appleButton.centerXAnchor.constraint(equalTo: self.registerButtonLayout.centerXAnchor),
        appleButton.topAnchor.constraint(equalTo: self.registerButtonLayout.bottomAnchor, constant: 10),
        appleButton.widthAnchor.constraint(equalToConstant: self.registerButtonLayout.frame.width * 5/7)
        ])
    }
    
    @objc
       func didTapAppleButton() {
           let provider = ASAuthorizationAppleIDProvider()
           let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
           
           let controller = ASAuthorizationController(authorizationRequests: [request])
           
           controller.delegate = self
           controller.presentationContextProvider = self
           
           controller.performRequests()
       }
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
        self.backToRoot()

    }
    
    @IBAction func privacyButton(_ sender: Any) {
        
        let urlString = "https://www.privacypolicies.com/privacy/view/9365f69ef7a7434aeed4d5f09ca3f683"
        let url = URL(string: urlString)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        treasureView.isHidden = true
        navigationController?.isNavigationBarHidden = true
        setLoginView()
        showAppleSignIn()
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
        
        self.userNameView.image = UIImage(named:"account")
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
        userNameTextfield.delegate = self
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
                    
                    KeyChainManager.shared.set(Auth.auth().currentUser!.uid, forKey: "userid")
                    KeyChainManager.shared.set(self.emailTextField.text!, forKey: "useremail")
                    
                    let db = Firestore.firestore()
                    
                    let data: [String: Any] = ["userName": self.userNameTextfield.text!,"email": self.emailTextField.text! ]
                    db.collection("user").document((KeyChainManager.shared.get("userid")!)).setData(data){ (error) in
                        if let error = error {
                            print(error)
                        }else {
                            print((KeyChainManager.shared.get("userid")!) as Any)
                        }
                    }
                    
                    self.backToRoot()
                    
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
           
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    KeyChainManager.shared.set(Auth.auth().currentUser!.uid, forKey: "userid")
                    KeyChainManager.shared.set(self.emailTextField.text!, forKey: "useremail")
                    
                    UserManager.shared.getUserData(completion: {user in
                        
                        if user?.totalScore != nil {
                            ProfileViewController.totalScore = user!.totalScore!
                        }
                        
                        if user?.loginCounts != nil {
                            ProfileViewController.loginCounts = user!.loginCounts!
                        }
                    })
             
                    self.backToRoot()
                
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
                               "userName": user.lastName + user.firstName] as [String : Any]
            
                let db = Firestore.firestore()
            
                db
                    .collection("user")
                    .document(user.id)
                    .setData(loginRecord,merge: true,
                             completion: {[weak self] (error) in
                                if let error = error {
                                    print(error)
                                }
                                self?.backToRoot()
                    })
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

extension AuthViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return view.window!
    }
   
}

extension AuthViewController: UITextFieldDelegate,UITextViewDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let countOfWords = string.count +  textField.text!.count - range.length
     
        if countOfWords > 6 {
     
        let controller = UIAlertController(title: "字數過長", message: "用戶名稱須低於六個字！", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "OK", style:.cancel )
        controller.addAction(cancelAction)

        present(controller, animated: true, completion: nil)
        
        return false
       }
     
       return true
    }
}

