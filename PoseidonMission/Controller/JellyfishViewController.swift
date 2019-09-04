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

    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var openButtonOutlet: UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var middleUpFish: UIButton!
    @IBOutlet weak var jellyBackGroundView: UIImageView!
    
    @IBOutlet var holeCollection: [UIImageView]!
    
    @IBAction func startAction(_ sender: Any) {
        self.timerEanbled()
        openButtonOutlet.isEnabled = false
        
        UIView.animate(withDuration: 1.5) {
            
            self.middleUpFish.frame.origin.y -= 100
            self.middleUpFish.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
      
    }
    
    func timerEanbled(){
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondCount), userInfo: nil, repeats: true)
    }
    
    @objc func secondCount(){
        if (counter > 1){
            counter = counter - 1
            secondLabel.text = "\(counter)";
          
        }else{
            secondLabel.text = "時間到";
            self.timer?.invalidate()
            counter = 60
        }
    }
    
    
    func setJellyFishView(){
         jellyBackGroundView.image = UIImage(named: "jellyfishbackground")
        
        for hole in holeCollection {
            hole.image = UIImage(named: "hole")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appDelegate.interfaceOrientations = [.landscapeLeft, .landscapeRight]
        
        setJellyFishView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
 
        appDelegate.interfaceOrientations = .portrait
        
        if self.timer != nil{
            self.timer?.invalidate()
        }
    }

    
    

}
