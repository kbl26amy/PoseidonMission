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
    var fishButtons : [UIButton] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var openButtonOutlet: UIButton!
    
    @IBOutlet weak var jellyBackGroundView: UIImageView!
    
    @IBOutlet var holeCollection: [UIImageView]!
    
    @IBAction func startAction(_ sender: Any) {
        
        self.timerEanbled()
        
        openButtonOutlet.isEnabled = false
  
        }

    func jellyFishSetingAnimation(){
        
        let fishButton = fishButtons.randomElement()
        if counter % 2 == 0 {
        fishButton!.setImage(UIImage(named: "goodWaterMother"), for: .normal)
        }else {
        fishButton!.setImage(UIImage(named: "badWaterMother"), for: .normal)
        }
        view.addSubview(fishButton!)
        loadViewIfNeeded()
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: {
            fishButton!.alpha = 1
            fishButton!.frame.origin.y -= 50
            fishButton!.transform = CGAffineTransform(scaleX: 2.0, y: 2.0 )
        }){
            if $0
            {
                UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .beginFromCurrentState, animations:
                    {
                        fishButton!.alpha = 0
                        fishButton!.frame.origin.y += 50
                }, completion: nil)
            }
        
        }
    }
    
    func timerEanbled(){
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondCount), userInfo: nil, repeats: true)
    }
    
    @objc func secondCount(){
        if (counter > 1){
            counter = counter - 1
            jellyFishSetingAnimation()
            secondLabel.text = "\(counter)";
          
        }else{
            secondLabel.text = "時間到";
            self.timer?.invalidate()
            counter = 60
        }
    }
    
    func setJellyFishView()  {
        navigationController?.isNavigationBarHidden = true
        
        appDelegate.interfaceOrientations = [.landscapeLeft, .landscapeRight]
        
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
        
        fishButtons = [middleUpJellyFish, leftUpJellyFish, rightUpJellyFish, middleDownJellyFish, leftDownJellyFish, rightDownJellyFish]
        loadViewIfNeeded()
       
        var index = 0
        for button in fishButtons{
        
        view.addSubview(button)
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
        
        setJellyFishView()
    }
}
