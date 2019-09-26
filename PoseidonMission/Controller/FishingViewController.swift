//
//  FishingViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import Firebase

class FishingViewController: UIViewController {

    let fishGenerater: [FishGenerator] = [PathOne(),
                                          PathTwo(),
                                          PathThree(),
                                          PathForth(),
                                          PathFifth()]
    var fishViews: [UIImageView] = []
    var timer:Timer?
    var fishingTimer: Timer?
    var isSucess: Bool = false
    var fishingCounts = 10 {
        didSet {
             self.fishingChance.text = "您還有\(self.fishingCounts)次釣魚機會"
        }
    }
    var score = 0 {
        didSet {
             self.scoreLabel.text = "\(score)分"
        }
    }
 
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var fishingChance: UILabel!
    @IBOutlet weak var fishsView: UIView!
    @IBOutlet weak var ship: UIImageView!
    @IBOutlet weak var fishingButton: UIButton!
    @IBOutlet weak var chanceBagroundView: UIView!
    @IBOutlet weak var fishingBackground: UIImageView!
    @IBOutlet weak var fishingRod: UIImageView!
    @IBOutlet weak var energyBar: UIImageView!
    @IBOutlet weak var leftMoveButton: UIButton!
    @IBOutlet weak var rightMoveButton: UIButton!
    @IBOutlet weak var fishingLine: UIImageView!
    
    @IBOutlet weak var sucessText: UILabel!
    @IBOutlet weak var failureText: UILabel!
    
    var energyBarAnimator: UIViewPropertyAnimator?
    
    let colorView = UIView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: 0,
                                         height: UIScreen.main.bounds.height / 26)
    )
    
    @IBAction func backButton(_ sender: Any) {
        
        backToRoot()
    }
    
    @IBOutlet var moveButtonCollection: [UIButton]!
    @IBOutlet weak var shipTrailingConstraint: NSLayoutConstraint!
    
    @IBAction func clickLeftButton(_ sender: Any) {
        self.view.layoutIfNeeded()
    
        let clikLeftAnimator = UIViewPropertyAnimator()
        clikLeftAnimator.addAnimations {
   
            self.shipTrailingConstraint.constant -= 10
            self.view.layoutIfNeeded()

                }
    
        clikLeftAnimator.startAnimation()

    }
    
    @IBAction func clickRightButton(_ sender: Any) {
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                       delay: 0,
                                                       animations: {
            self.ship.frame.origin.x += 10
            self.fishingRod.frame.origin.x += 10
            self.fishingLine.frame.origin.x += 10
        }, completion: nil)
        
    }
    @IBAction func clickFishingButton(_ sender: UIButton) {
        
         self.energyBarAnimator?.stopAnimation(true)
       
        for button in self.moveButtonCollection{ button.isEnabled = false
        }
        
        if self.colorView.frame.width >= self.energyBar.frame.width * 0.95 {
            
            if fishingCounts > 0 {
            rotateUpRod(sender)
            } else {
                let alertController = UIAlertController(title: "次數不足",
                                                        message: "您的魚餌不足，請明日再來",
                                                        preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    
                    self.backToRoot()
                    
                }
                
                alertController.addAction(defaultAction)
                
                present(alertController, animated: true, completion: nil)
                
            }
            
        } else {
            
            let alertController = UIAlertController(title: "失敗",
                                                    message: "能量條不足",
                                                    preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default) { (_) in
                
                     self.energyBarAnimation()
                }
      
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
 
        }
 
    }
    
    func checkFishingHighest() {
        
        UserManager.shared.getUserData(completion:  { user in
            
            if user?.fishingHighest != nil {
                if self.score > (user?.fishingHighest)! {
                    ProfileViewController.fishingHighest = self.score
                    
                }
            }else {
                ProfileViewController.fishingHighest = self.score
            }
        })

        let updateData = ["fishingHighest":ProfileViewController.fishingHighest] as [String : Any]
        
        FireBaseHelper.updateData(update: updateData)
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        setFishingView()
        checkIsFishingToday()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        
        self.timerEanbled()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        energyBarAnimation()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
        self.timer?.invalidate()
        self.fishingTimer?.invalidate()
       
    }
    
    func energyBarAnimation() {
     
        self.colorView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: 0,
                                      height: UIScreen.main.bounds.height / 26)
        colorView.backgroundColor = UIColor(red: 249/255, green: 191/255, blue: 90/255, alpha: 1)
        
        self.energyBar.addSubview(colorView)
        
        energyBarAnimator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2.0,
                                                                           delay: 0,
                                                                           options: .repeat,
                                                                           animations: {
            UIView.setAnimationRepeatCount(999);
            
            self.colorView.frame = CGRect(x: 0,
                                          y: 0,
                                          width: self.energyBar.frame.width,
                                          height: self.energyBar.frame.height)
            
        }, completion: nil)
        
        energyBarAnimator?.startAnimation()
    }
    
    func setFishingView() {
        
        ship.image = UIImage(named: "ship")
        chanceBagroundView.layer.cornerRadius = 10
        fishingButton.layer.cornerRadius = 10
        fishingBackground.image = UIImage(named: "background")
        fishingRod.image = UIImage(named: "fishingRod")
        fishingLine.image = UIImage(named: "fishingLine")
        rightMoveButton.setImage(UIImage(named: "rightButton"), for: .normal)
        leftMoveButton.setImage(UIImage(named: "leftButton"), for: .normal)
        energyBar.layer.cornerRadius = 10
        energyBar.layer.borderWidth = 3
        energyBar.layer.borderColor = #colorLiteral(red: 0.1359939873, green: 0.3958500326, blue: 0.4860774279, alpha: 1)
        pathLayer.removeAllAnimations()
        sucessText.text = "積分 ＋150"
        sucessText.alpha = 0
       
    }
    
   
    
    func rotateUpRod(_ sender: Any) {
      
        var rodUpAnimation: UIViewPropertyAnimator?
        var rodDownAnimation: UIViewPropertyAnimator?
        self.isSucess = false
        self.fishingCounts -= 1
        
        rodUpAnimation =  UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                                        delay: 0,
                                                                        options:.beginFromCurrentState,
                                                                        animations: {
                                                                            
            self.fishingLine.alpha = 0
            self.fishingRod.transform = CGAffineTransform(rotationAngle: (20.0 * .pi) / 90.0)
 
        }, completion: nil)
        rodUpAnimation?.startAnimation()

        rodUpAnimation?.addCompletion() {_ in
            rodDownAnimation = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                                              delay: 0,
                                                                              options:.beginFromCurrentState,
                                                                              animations: {

                self.fishingRod.transform = CGAffineTransform(rotationAngle: (-20.0 * .pi) / 90.0)

            }, completion: nil)

            rodDownAnimation?.startAnimation()
            rodDownAnimation?.addCompletion() {_ in

                self.fishLineAnimation()

            }
        }
    }
    
    var fishTouchSquare:UIView!
    let pathLayer = CAShapeLayer()
    let pathAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
    
    func fishLineAnimation() {
        
        fishTouchSquare = UIImageView(image: UIImage(named: "fishingHook"))
        fishTouchSquare.frame = CGRect(x: -100, y: 0, width: 15, height: 15)
      
        let fishingRodWidth = self.fishingRod.frame.width
        let decreaseX = fishingRodWidth - CGFloat(cos(40 * Double.pi / 180)) * fishingRodWidth
        let centerX = self.fishingRod.frame.origin.x + decreaseX
        let transform = CGAffineTransform(translationX: centerX, y: 5)
        let path =  CGMutablePath()
        path.move(to: CGPoint(x:0 ,y:0), transform: transform)
        path.addLine(to: CGPoint(x: 0 ,
                                 y: UIScreen.main.bounds.height * 3 / 4 - 40),
                     transform: transform)
        
        let orbit = CAKeyframeAnimation(keyPath:"position")
        orbit.duration = 4
        orbit.path = path
        orbit.calculationMode = CAAnimationCalculationMode.paced
        orbit.isRemovedOnCompletion = false
        orbit.fillMode = CAMediaTimingFillMode.forwards
        fishTouchSquare.layer.add(orbit,forKey:"Move")
        
        pathLayer.frame = self.view.bounds
        pathLayer.path = path
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 1
        pathLayer.strokeColor = UIColor.darkGray.cgColor
    
       
        pathAnimation.duration = 4
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        pathAnimation.delegate = self
        // CABasicAnimation 在被加到 layer 時，會複製一份 object 加上去
        pathLayer.add(pathAnimation , forKey: "strokeEnd")
        pathAnimation.duration = 0.5

        self.fishsView.addSubview(fishTouchSquare)
        self.fishsView.layer.addSublayer(pathLayer)
        fishingProcess()
        
    }
    
    @objc func fishingSucess() {
        
        for fish in fishViews {
      
            // CAlayer 屬性
            let fishTouchX = Int((fishTouchSquare.layer.presentation()?.frame.origin.x)! + 12)
            let fishTouchY = Int((fishTouchSquare.layer.presentation()?.frame.origin.y)! + 12)
            let fishX = Int((fish.layer.presentation()?.frame.origin.x)!)
            let fishY = Int((fish.layer.presentation()?.frame.origin.y)!)
          
            if  fishTouchX >= fishX - 40 && fishTouchY >= fishY - 20 &&
                fishTouchX <= fishX + Int((fish.layer.presentation()?.frame.width)!) + 40 &&
                fishTouchY <= fishY + Int((fish.layer.presentation()?.frame.height)!) + 20 {

                self.resetAnimation()
                self.isSucess = true
                self.score += 150
               
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1,
                                                               delay: 0,
                                                               animations: {
                   fish.frame.origin.y = -80
                   fish.frame.origin.x = self.view.bounds.width
                   
                   self.sucessText.frame.origin.y -= 40;
                   self.sucessText.alpha = 1
                   self.sucessText.transform.scaledBy(x: 3, y: 3)
                                                                
                }, completion: { _ in
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1,
                                                                   delay: 0,
                                                                   animations: {
                                                                    
                    self.sucessText.alpha = 0
                    fish.alpha = 0
                                                                      })
                })
                
                break
            }
        }
        
    }
    
    func fishingFailure() {
        
       UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1,
                                                       delay: 0,
                                                       animations: {
                 self.failureText.frame.origin.y -= 80;
                 self.failureText.alpha = 1
                 self.failureText.transform.scaledBy(x: 3, y: 3)
                                                        
        }, completion: { _ in
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2,
                                                           delay: 0,
                                                           animations: {
            self.failureText.alpha = 0
            })
        })
        
         self.resetAnimation()
      
    }
    
    func resetAnimation(){
        for button in self.moveButtonCollection{
            button.isEnabled = true
        }
        self.pathLayer.removeFromSuperlayer()
        self.fishTouchSquare.removeFromSuperview()
        self.fishingLine.layer.removeAllAnimations()
        self.fishingLine.alpha = 1
        self.fishingLine.layer.transform = CATransform3DIdentity
        self.fishingRod.layer.removeAllAnimations()
        self.fishingRod.layer.transform = CATransform3DIdentity
        self.energyBarAnimation()
        self.fishingTimer?.invalidate()
        
    }
    
    func timerEanbled() {
        
        self.timer = Timer.scheduledTimer(timeInterval: 2,
                                          target: self,
                                          selector: #selector(generateFish),
                                          userInfo: nil, repeats: true)
    }
    
    func fishingProcess() {
        
        self.fishingTimer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(fishingSucess),
                                          userInfo: nil, repeats: true)
    }
    
    @objc func generateFish(){
        
        fishViews.append(fishGenerater.randomElement()!.fetchFishImageView())
        self.fishsView.addSubview(fishViews.last!)
    }
    
    func saveFishingData() {
        
        let updateData = ["fishingCounts": self.fishingCounts,
                          "currentFishingScore":  self.score,
                      "fishingTime": FirebaseFirestore.Timestamp(date:Date())] as [String : Any]
    
        FireBaseHelper.updateData(update: updateData)
    }
    
    func saveFishingRecord() {
        let fishingRecord = ["score":self.score / 300, "source": "fishing", "time": FirebaseFirestore.Timestamp(date:Date()) ] as [String : Any]
        
        FireBaseHelper.saveUserRecord(saveData: fishingRecord)
        
        let updateData = ["totalScore": ProfileViewController.totalScore + self.score / 300] as [String : Any]
        
        FireBaseHelper.updateData(update: updateData)
    }
    
    func checkIsFishingToday() {
        
        UserManager.shared.getUserData(completion: {user in
            if user?.fishingTime != nil {
                let timestamp = user?.fishingTime
                let converted = Date(timeIntervalSince1970: TimeInterval(timestamp!.seconds) )
                
                let now:Date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = NSTimeZone.local
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let fishingTime = dateFormatter.string(from: converted as Date)
                let currentTime = dateFormatter.string(from: now as Date)
                
                if fishingTime != currentTime {
                    self.fishingCounts = 10
                    self.score = 0
                 
                } else {
                    if user?.fishingCounts != nil {
                        self.fishingCounts = (user?.fishingCounts)!
                    }
                    
                    if user?.currentFishingScore != nil {
                        self.score = (user?.currentFishingScore)!
                    }
                }
            } else {
                if user?.fishingCounts != nil {
                    self.fishingCounts = (user?.fishingCounts)!
                }else {
                    self.fishingCounts = 10
                }
                
                if user?.currentFishingScore != nil {
                    self.score = (user?.currentFishingScore)!
                }else {
                    self.score = 0
                }
            }
        })
    }
}

extension FishingViewController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        saveFishingData()
        checkFishingHighest()
        if self.isSucess == false {
        fishingFailure()
        }
        
        if self.fishingCounts == 0 {
            saveFishingRecord()
        }
    }
}
