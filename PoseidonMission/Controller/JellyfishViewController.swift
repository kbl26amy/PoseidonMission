//
//  JellyfishViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class JellyfishViewController: PMBaseViewController {
    
    var timeStop:Int!
    var timer:Timer?
    var counter = 60
    var index = 0
    var fishButtons : [UIButton] = []
    var score = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func leaveButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
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
        print("click JellyFish")
        if sender.imageView?.image == UIImage(named: "badWaterMother"){
            score += 150
            scoreLabel.text = "分數：\(score)"
        }else {
            score -= 150
            scoreLabel.text = "分數：\(score)"
            
        }
    }

    func jellyFishSetingAnimation(){
        
        let animateButton = fishButtons.randomElement()!
        print(animateButton.frame)

        if counter % 2 == 0 {
            animateButton.setImage(UIImage(named: "goodWaterMother"), for: .normal)
       
        }else {
            animateButton.setImage(UIImage(named: "badWaterMother"), for: .normal)
        
        }
        view.addSubview(animateButton)
        loadViewIfNeeded()
        
        var upAnimation: UIViewPropertyAnimator?
        var downAnimation: UIViewPropertyAnimator?
        
        upAnimation = UIViewPropertyAnimator(duration: 1.9, dampingRatio: 30, animations: {
            animateButton.alpha = 1
            animateButton.frame.origin.y -= 50
            animateButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0 )
        })
        upAnimation?.startAnimation()
        upAnimation?.addCompletion() {_ in
        downAnimation = UIViewPropertyAnimator(duration: 0.1, dampingRatio: 30, animations: {
                        animateButton.alpha = 0
                        animateButton.frame.origin.y += 50
                })
        downAnimation?.startAnimation()
        }
    }
    
    func timerEanbled(){
        
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(secondCount),
                                          userInfo: nil, repeats: true)
    }
    
    @objc func secondCount(){
        if (counter > 1){
            counter = counter - 1
            jellyFishSetingAnimation()
            secondLabel.text = "\(counter)";
          
        }else{
            
            let controller = UIAlertController(title: "遊戲結束", message: "您的分數為\(score)，是否直接計算點數？", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .default) { (_) in
                print("開始計算分數")
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            controller.addAction(okAction)
            
            let cancelAction = UIAlertAction(title: "再玩一次", style:.default ){ (_) in
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
        
        let middleUpJellyFish = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let leftUpJellyFish = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let rightUpJellyFish = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let leftDownJellyFish = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let rightDownJellyFish = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let middleDownJellyFish = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        fishButtons = [middleUpJellyFish, leftUpJellyFish, rightUpJellyFish,
                       middleDownJellyFish, leftDownJellyFish, rightDownJellyFish]
        loadViewIfNeeded()
    
        for button in fishButtons{
        
            view.addSubview(button)
            button.addTarget(self, action: #selector(getScore(_:)), for: .touchUpInside)
            
            button.alpha = 0
            button.setImage(UIImage(named: "badWaterMother"), for: .normal)
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
 
        appDelegate.interfaceOrientations = .portrait
        
        if self.timer != nil{
            self.timer?.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate.interfaceOrientations = [.landscapeLeft, .landscapeRight]
        setJellyFishView()
        
    }
}
