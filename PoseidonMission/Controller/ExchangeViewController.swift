//
//  ExchangeViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/10/2.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import Firebase

class ExchangeViewController: PMBaseViewController {

    var rewardPics = RewardGroup( item: [
         Rewards.coupon,
         Rewards.pearl,
         Rewards.seaweed,
         Rewards.bottle
     ])
    
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var exchangeCouponLabel: UILabel!
    @IBOutlet weak var getRewardButton: UIButton!
    @IBAction func getReward(_ sender: Any) {
        
        self.maskView.alpha = 0
        self.resultView.alpha = 0
        self.treasureView.alpha = 1
        self.exchangeButton.alpha = 1
        self.rewardLabel.alpha = 0
        self.introductionLabel.alpha = 0
        self.getRewardButton.alpha = 0
        self.exchangeLabel.alpha = 1
    }
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var resultView: UIImageView!
    @IBOutlet weak var coinView: UIImageView!
    
    @IBAction func backButton(_ sender: Any) {

        tabBarController?.selectedIndex = 0
        
    }
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var treasureView: UIImageView!
    @IBOutlet weak var exchangeButton: UIButton!
    
    @IBAction func exchangeAction(_ sender: Any) {
        if UserManager.totalScore >= 10 {
            
            self.coinView.alpha = 1
            var coinAnimation: UIViewPropertyAnimator?
            coinAnimation = UIViewPropertyAnimator
                .runningPropertyAnimator(withDuration: 1,
                                         delay: 0,
                                         options: .transitionCurlDown,
                                         animations: {
                self.treasureAnimation()
                self.coinView.frame.origin.y += 300
                self.coinView.alpha = 0
                                            
            }, completion: nil)
            
            coinAnimation?.startAnimation()
            coinAnimation?.addCompletion({ _ in
                
                self.coinView.frame.origin.y -= 300
                self.showResult()
                
            })
            
        }else {
            
            UIAlertController.showAlert(message: "暢遊卷不足")
        }
    }
    
    func showResult() {
       
        self.maskView.alpha = 0.3
        self.resultView.alpha = 1
        self.treasureView.alpha = 0
        self.exchangeButton.alpha = 0
        self.rewardLabel.alpha = 1
        self.introductionLabel.alpha = 1
        self.exchangeLabel.alpha = 0
        self.getRewardButton.alpha = 1
        self.getRewardButton.layer.cornerRadius = 15
        
        UserManager.totalScore -= 10
        self.exchangeCouponLabel.text = "暢遊卷：\(UserManager.totalScore)張"
        
        let reward = self.rewardPics.item.randomElement()
        self.resultView.image = reward?.image!
        self.rewardLabel.text = "恭喜你獲得\(reward!.title)"
        self.introductionLabel.text = reward?.introduction
        
        let scoreData = ["totalScore":UserManager.totalScore]
        FireBaseHelper.updateData(update: scoreData)
        
        let exchangeData = ["item": reward?.title as Any,
                            "introduction":reward?.introduction as Any,
                            "time": FirebaseFirestore.Timestamp(date:Date()) ] as [String : Any]
        FireBaseHelper.saveExchangeRecord(saveData: exchangeData)
    }
    
    func treasureAnimation() {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.fromValue = -Double.pi / 6
        animation.toValue = Double.pi / 6
        animation.duration = 0.2
        animation.autoreverses = true
        animation.repeatCount = 3
        
        self.treasureView.layer.add(animation, forKey: "shakeAnimation")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
 
        coinView.image = UIImage.asset(.coin)
        treasureView.image = UIImage.asset(.treasureBox)
        exchangeButton.layer.cornerRadius = 15
        background.image =  UIImage.asset(.background)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        view.layoutIfNeeded()
        UserManager.shared.getUserData(completion:  { user in
            
            if user?.totalScore != nil {
                UserManager.totalScore = user!.totalScore!
                self.exchangeCouponLabel.text = "暢遊卷：\(user?.totalScore ?? 0)張"
            }else {
                self.exchangeCouponLabel.text = "暢遊卷：0張"
            }
            
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           self.tabBarController?.tabBar.isHidden = false
       }
}
