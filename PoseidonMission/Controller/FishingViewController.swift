//
//  FishingViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class FishingViewController: UIViewController {

    let fishGenerater: [FishGenerator] = [PathOne(), PathTwo(), PathThree(), PathForth()]
    var fishViews: [UIImageView] = []
    var timer:Timer?
 
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
    
    var energyBarAnimator: UIViewPropertyAnimator?
    
    let colorView = UIView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: 0,
                                         height: UIScreen.main.bounds.height / 26)
    )
    
    @IBAction func backButton(_ sender: Any) {
        
        backToRoot()
    }
    
    @IBAction func clickLeftButton(_ sender: Any) {
        var shipLeftAnimation = UIViewPropertyAnimator()
        shipLeftAnimation = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                                           delay: 0,
                                                                           animations: {
                self.ship.frame.origin.x -= 10
                self.fishingRod.frame.origin.x -= 10
                self.fishingLine.frame.origin.x -= 10
                }, completion: nil)
        
        shipLeftAnimation.startAnimation()
    }
    
    @IBAction func clickRightButton(_ sender: Any) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, animations: {
            self.ship.frame.origin.x += 10
            self.fishingRod.frame.origin.x += 10
            self.fishingLine.frame.origin.x += 10
        }, completion: nil)
        
    }
    @IBAction func clickFishingButton(_ sender: UIButton) {
        
         self.energyBarAnimator?.stopAnimation(true)
        
        if self.colorView.frame.width >= self.energyBar.frame.width * 0.95 {
            
            let sucessText = UILabel(frame: self.colorView.frame)
            sucessText.textColor = .white
            sucessText.text = "能量充足"
            sucessText.textAlignment = .center
            self.colorView.addSubview(sucessText)
            rotateUpRod(sender)
            
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
  
    let animation = CABasicAnimation()
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        setFishingView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        energyBarAnimation()
        self.timerEanbled()

    }
    
    func energyBarAnimation() {
     
        self.colorView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: 0,
                                      height: UIScreen.main.bounds.height / 26)
        colorView.backgroundColor = .red
        
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
        chanceBagroundView.layer.cornerRadius = 15
        fishingButton.layer.cornerRadius = 15
        fishingBackground.image = UIImage(named: "background")
        fishingRod.image = UIImage(named: "fishingRod")
        fishingLine.image = UIImage(named: "fishingLine")
        rightMoveButton.setImage(UIImage(named: "rightButton"), for: .normal)
        leftMoveButton.setImage(UIImage(named: "leftButton"), for: .normal)
        energyBar.layer.cornerRadius = 15
        energyBar.layer.borderWidth = 3
        energyBar.layer.borderColor = #colorLiteral(red: 0.1359939873, green: 0.3958500326, blue: 0.4860774279, alpha: 1)
    }
    
    func rotateUpRod(_ sender: Any) {
  
        var rodUpAnimation: UIViewPropertyAnimator?
        var rodDownAnimation: UIViewPropertyAnimator?
      
        rodUpAnimation = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                                        delay: 0,
                                                                        animations: {
            
            self.fishingLine.alpha = 0
            self.fishingRod.transform = CGAffineTransform(rotationAngle: (20.0 * .pi) / 90.0)
 
        }, completion: nil)
        rodUpAnimation?.startAnimation()
        
        rodUpAnimation?.addCompletion() {_ in
            rodDownAnimation = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                                              delay: 0,
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
    
    func fishLineAnimation() {
        
        fishTouchSquare = UIImageView(image: UIImage(named: "fishingHook"))
        fishTouchSquare.frame = CGRect(x: -100, y: 0, width: 25, height: 25)
      
        let fishingRodWidth = self.fishingRod.frame.width
        let decreaseX = fishingRodWidth - CGFloat(cos(40 * Double.pi / 180)) * fishingRodWidth
        let centerX = self.fishingRod.frame.origin.x + decreaseX
        let transform = CGAffineTransform(translationX: centerX, y: 5)
        let path =  CGMutablePath()
        path.move(to: CGPoint(x:0 ,y:0), transform: transform)
        path.addLine(to: CGPoint(x: 0 ,
                                 y: UIScreen.main.bounds.height - 400),
                     transform: transform)
        
        let orbit = CAKeyframeAnimation(keyPath:"position")
        orbit.duration = 5
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
    
        let pathAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        pathAnimation.duration = 5
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
            print(fish.layer.presentation()?.frame.origin.x as Any)
            print(fishTouchSquare.layer.presentation()?.frame.origin.x as Any)
            print(fish.layer.presentation()?.frame.origin.y as Any)
            print(fishTouchSquare.layer.presentation()?.frame.origin.y as Any)
         
            let fishTouchX = Int((fishTouchSquare.layer.presentation()?.frame.origin.x)! + 40)
            let fishTouchY = Int((fishTouchSquare.layer.presentation()?.frame.origin.y)! )
            let fishX = Int((fish.layer.presentation()?.frame.origin.x)!) + 40
            
            let fishY = Int((fish.layer.presentation()?.frame.origin.y)!)
            
            print(fishTouchX)
            print(fishX)
            if  fishTouchX >= fishX - 50 && fishTouchY >= fishY - 50 &&  fishTouchX <= fishX + 50  && fishTouchY <= fishY + 50 {

                let alertController = UIAlertController(title: "成功",
                                                        message: "積分 ＋ 150",
                                                        preferredStyle: .alert)

                let defaultAction = UIAlertAction(title: "OK", style: .default) { (_) in

                    print("積分 ＋ 150")
                }

                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
            
            }
        }
        
    }
    
    func fishingFailure() {
        
        print(fishTouchSquare.frame)
        
        let alertController = UIAlertController(title: "失敗",
                                                message: "沒有釣到任何魚",
                                                preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default) { (_) in
       
            self.loadView()
            self.setFishingView()
            self.energyBarAnimation()
            
        }
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func timerEanbled() {
        
        self.timer = Timer.scheduledTimer(timeInterval: 2,
                                          target: self,
                                          selector: #selector(generateFish),
                                          userInfo: nil, repeats: true)
    }
    
    func fishingProcess() {
        
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(fishingSucess),
                                          userInfo: nil, repeats: true)
    }
    
    @objc func generateFish(){
        
        fishViews.append(fishGenerater.randomElement()!.fetchFishImageView())
        self.fishsView.addSubview(fishViews.last!)
    }
            
}

extension FishingViewController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        fishingFailure()
        
    }
}
