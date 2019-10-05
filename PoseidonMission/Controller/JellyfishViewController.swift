//
//  JellyfishViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import Firebase

class JellyfishViewController: PMBaseViewController {
    
    var timeStop:Int!
    var timer:Timer?
    var counter: Double = 60.0
    var index = 0
    var jellyfishButtons : [UIButton] = []
    var score = 0
    var jellyFishCouldTimes = 1
    let appDelegate = UIApplication.shared.delegate
        as! AppDelegate
    
    @IBAction func leaveButton(_ sender: Any) {
        appDelegate.interfaceOrientations = .portrait
        
        self.backToRoot()
    }
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var openButtonOutlet: UIButton!
    
    @IBOutlet weak var jellyBackGroundView: UIImageView!
    
    @IBOutlet var holeCollection: [UIImageView]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func startAction(_ sender: Any) {
        
        self.timerEanbled()
        
        openButtonOutlet.isEnabled = false
   
        }
    
    @objc func getScore(_ sender: UIButton){
        
        if sender.imageView?.image == UIImage.asset(.badJellyfish) {
            sender.isEnabled = true
            score += 150
            scoreLabel.text = "分數：\(score)"
            sender.setImage(UIImage.asset(.badJellyfishClick), for: .normal)
            
        }else if sender.imageView?.image == UIImage.asset(.goodJellyfish){
            sender.isEnabled = true
            score -= 150
            scoreLabel.text = "分數：\(score)"
            sender.setImage(UIImage.asset(.goodJellyfishClick), for: .normal)
          
        }
    }

    func jellyFishSetingAnimation(){
        
        let animateButton = jellyfishButtons.randomElement()!
         
        let result = counter.truncatingRemainder(dividingBy: 1)
        if result == 0 {
            animateButton.setImage(UIImage.asset(.goodJellyfish), for: .normal)
       
        }else {
            animateButton.setImage(UIImage.asset(.badJellyfish), for: .normal)
        
        }
        view.addSubview(animateButton)
        loadViewIfNeeded()
        
        var upAnimation: UIViewPropertyAnimator?
        var downAnimation: UIViewPropertyAnimator?
        
        upAnimation = UIViewPropertyAnimator(duration: 1.9,
                                             dampingRatio: 30,
                                             animations: {
            animateButton.alpha = 1
            animateButton.frame.origin.y -= 50
            animateButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0 )
        })
        upAnimation?.startAnimation()
        upAnimation?.addCompletion() {_ in
        downAnimation = UIViewPropertyAnimator(duration: 0.1,
                                               dampingRatio: 30,
                                               animations: {
                        animateButton.alpha = 0
                        animateButton.frame.origin.y += 50
                })
        downAnimation?.startAnimation()
        }
    }
    
    func timerEanbled(){
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.5,
                                          target: self,
                                          selector: #selector(secondCount),
                                          userInfo: nil, repeats: true)
    }
    
    @objc func secondCount(){
        if (counter > 0.5){
            counter = counter - 0.5
            jellyFishSetingAnimation()
            secondLabel.text = "\(Int(counter))";
          
        }else{
           
            let controller = UIAlertController(title: "遊戲結束",
                                               message: "您的分數為\(score)，是否直接計算點數？",
                preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的",
                                         style: .default) { (_) in
              
                if self.score >= 0 {
                    self.saveData()
                    self.appDelegate.interfaceOrientations = .portrait
                    self.backToRoot()
                } else {
                    let controller = UIAlertController(title: "分數不足",
                                                       message: "分數需大於0分才可以獲得暢遊卷，請重新遊戲",
                                                       preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "好的",
                                                style: .default) { (_) in
                    
                    self.counter = 60
                    self.score = 0
                    self.scoreLabel.text = "分數：0"
                    self.secondLabel.text = "60"
                    self.openButtonOutlet.isEnabled = true
                    }
                    controller.addAction(okAction)
                    self.present(controller, animated: true, completion: nil)
                }
            }
            
            controller.addAction(okAction)
            
            let cancelAction = UIAlertAction(title: "再玩一次",
                                             style:.default ){ (_) in
                self.counter = 60
                self.score = 0
                self.scoreLabel.text = "分數：0"
                self.secondLabel.text = "60"
                self.openButtonOutlet.isEnabled = true
         
            }
            controller.addAction(cancelAction)
            
            present(controller, animated: true, completion: nil)
            
            secondLabel.text = "時間到";
            self.timer?.invalidate()
            counter = 60
        }
    }
    
    func setJellyFishView()  {
        navigationController?.isNavigationBarHidden = true
        
        jellyBackGroundView.image = UIImage(named: "jellyfishbackground")
        
        for hole in holeCollection {
            hole.image = UIImage(named: "hole")
        }
        
        let middleUpJellyFish = UIButton()
        let leftUpJellyFish = UIButton()
        let rightUpJellyFish = UIButton()
        let leftDownJellyFish = UIButton()
        let rightDownJellyFish = UIButton()
        let middleDownJellyFish = UIButton()
        
        jellyfishButtons = [middleUpJellyFish, leftUpJellyFish, rightUpJellyFish,
                       middleDownJellyFish, leftDownJellyFish, rightDownJellyFish]
        loadViewIfNeeded()
    
        for button in jellyfishButtons{
        
            view.addSubview(button)
            button.addTarget(self,
                             action: #selector(getScore(_:)),
                             for: .touchUpInside)
            
            if button.imageView?.image == UIImage.asset(.goodJellyfishClick) || button.imageView?.image == UIImage.asset(.badJellyfishClick){
                        button.isHighlighted = false
                        button.showsTouchWhenHighlighted = false
                        
                    }else {
                        button.isEnabled = true
                        
                    }

            button.alpha = 0
            button.setImage(UIImage.asset(.badJellyfish), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalTo: holeCollection[index].widthAnchor, multiplier: 0.25).isActive = true
            button.heightAnchor.constraint(equalTo: holeCollection[index].heightAnchor, multiplier: 0.5).isActive = true
            button.centerXAnchor.constraint(equalTo: holeCollection[index].centerXAnchor).isActive = true
            button.centerYAnchor.constraint(equalTo: holeCollection[index].centerYAnchor, constant: -50).isActive = true
      
            index += 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.timer != nil{
            self.timer?.invalidate()
        }
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate.interfaceOrientations = [.landscapeLeft,
                                             .landscapeRight]
        setJellyFishView()
        isTodayJellyFish()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkJellyFishTimes()
    }
    
    func saveData(){
 
        let scoreRecordData: [String: Any] = ["time":
            FirebaseFirestore.Timestamp(date:Date()) ,
             "score": score/1000,
             "source": "jellyFish" ]
        
        FireBaseHelper.saveUserRecord(saveData: scoreRecordData)
    
        UserManager.shared.getUserData(completion:  { user in
            
            if user?.jellyFishHighest != nil {
                if self.score > (user?.jellyFishHighest)! {
                    UserManager.jellyFishHighest = self.score
                    self.saveUser()
                }
            }else {
                UserManager.jellyFishHighest = self.score
                self.saveUser()
            }
        })
        
    }
    
    func saveUser() {
        let updateData = ["totalScore": UserManager.totalScore + self.score/1000,
                          "jellyFishPlayTime": FirebaseFirestore.Timestamp(date:Date()),
                          "jellyFishHighest":UserManager.jellyFishHighest]
            as [String : Any]
        
        FireBaseHelper.updateData(update: updateData)
    }
   
    func checkJellyFishTimes() {
   
        UserManager.shared.getUserData(completion:  { user in
        
            if user?.totalScore != nil {
                UserManager.totalScore = user!.totalScore!
            }
                  
            if user?.jellyFishPlayTime != nil {
                        
                let jellyFishPlayTime = DateManager.timeStampToString(date:
                    user!.jellyFishPlayTime!)
                let currentTime = DateManager.dateToString(date: Date())
              
            if jellyFishPlayTime == currentTime {
                self.jellyFishCouldTimes -= 1
                self.isTodayJellyFish()
                } else {
                    print(jellyFishPlayTime)
                    print(currentTime)
                }
            }
        })
    }
    
    func isTodayJellyFish() {
        if jellyFishCouldTimes == 0 {
            
            UIAlertController.showConfirm(message: "您今日已經遊玩過了！",
                confirm: { (_) in
                    self.appDelegate.interfaceOrientations = .portrait
                    self.backToRoot()
            })
            
        }
        
    }
}
