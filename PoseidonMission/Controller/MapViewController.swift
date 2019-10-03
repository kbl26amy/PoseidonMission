//
//  MapViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MapViewController: PMBaseViewController {

    @IBOutlet weak var mapBackground: UIImageView!
    @IBOutlet weak var mapTitleLabel: UILabel!
    @IBOutlet weak var mapchanceLabel: UILabel!
    @IBOutlet weak var baseMapImage: UIImageView!
    @IBOutlet weak var seeRecordButton: UIButton!
    @IBOutlet weak var leaveOutlet: UIButton!
    
    @IBAction func leaveButton(_ sender: Any) {
        
        self.navigationController?
            .popToRootViewController(animated: true)
    
    }
    
    @IBAction func goToRecordPage(_ sender: Any) {
   
        let appdelegate = UIApplication.shared.delegate

        let tabBarController = appdelegate?
            .window??
            .rootViewController as? UITabBarController
        
        self.navigationController?.backToRoot()

        tabBarController?.selectedIndex = 3

    }
    
    var mapCouldTimes: Int = 1
   
    var currewntProgress: String? = "當前探索進度：0%"{
        
        didSet{
              mapchanceLabel.text = self.currewntProgress
        }
    }
    
    let firstButton = UIButton(frame:
        CGRect(x: UIScreen.main.bounds.width * 67 / 414 - 20,
               y: UIScreen.main.bounds.height * 89 / 736 - 20,
               width: 40,
               height: 40))
    
    let secondButton = UIButton(frame:
        CGRect(x:UIScreen.main.bounds.width  * 239 / 414 - 20,
               y: UIScreen.main.bounds.height * 56 / 736 - 20,
               width: 40,
               height: 40))
    
    let thirdButton = UIButton(frame:
        CGRect(x: UIScreen.main.bounds.width * 174 / 414 - 20,
               y: UIScreen.main.bounds.height * 205 / 736 - 20,
               width: 40,
               height: 40))
    let forthButton = UIButton(frame:
        CGRect(x: UIScreen.main.bounds.width * 310 / 414 - 20,
               y: UIScreen.main.bounds.height * 291 / 736 - 20,
               width: 40,
               height: 40))
    let fifthButton = UIButton(frame:
        CGRect(x: UIScreen.main.bounds.width * 351 / 414 - 20,
               y: UIScreen.main.bounds.height * 260 / 736 - 20,
               width: 40,
               height: 40))
    
    var buttons: [UIButton] = []
    var index = 0
    var result :[Bool] = [true, true, false, false, false]
    var scratchCard: ScratchCard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkMapTimes()
        showMap()
        mapchanceLabel.text = self.currewntProgress
        navigationController?.isNavigationBarHidden = true
        mapTitleLabel.adjustsFontSizeToFitWidth = true
        self.mapBackground.image = UIImage(named: "mapbackground")
        self.baseMapImage.image = UIImage(named: "showmap")
        
        self.leaveOutlet.layer.cornerRadius = 20
        self.seeRecordButton.layer.cornerRadius = 20

    }
    
    func showMap(){
        view.layoutIfNeeded()
    
        self.scratchCard = ScratchCard(frame: self.baseMapImage.frame,
                                      mapImage: UIImage(named: "showmap")!,
                                      maskImage: UIImage(named: "unmap")!)
        
        view.addSubview(scratchCard!)
        view.bringSubviewToFront(scratchCard!)
        scratchCard!.delegate = self
    }

}

extension MapViewController: ScratchCardDelegate {
    
    func scratchBegan(point: CGPoint) {
        print("Start：\(point)")
    }
    
    func scratchMoved(progress: Float) {
        print("Current：\(progress)")

        let percent = String(format: "%.1f", progress * 1000 / 8 )
        print("Finish：\(percent)%")
        self.currewntProgress = "當前探索進度：\(percent)%"
        
        if progress >= 0.8 {
        
            mapTitleLabel.text = "請選擇你要航行的地點"
            mapchanceLabel.text = "五個座標中，僅 2 處有寶藏"
            self.scratchCard?.isHidden = true
            view.layoutIfNeeded()
            self.setButton()
        }
    }

    func setButton() {
        
        self.baseMapImage.isUserInteractionEnabled = true
        
        self.buttons = [self.firstButton,
                        self.secondButton,
                        self.thirdButton,
                        self.forthButton,
                        self.fifthButton]
        
        for button in self.buttons{
                button.tag = index
                button.showsTouchWhenHighlighted = true
                button.setTitle("📌", for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 25)
                button.addTarget(self,
                                 action: #selector(self.showResult),
                                 for: .touchUpInside)
                self.baseMapImage.addSubview(button)
                index += 1
                }
        
    }
    
    func isTodayMap() {
        if mapCouldTimes == 0 {
            changeText()
           
            self.baseMapImage.image = UIImage(named: "nomap")
            self.scratchCard?.isHidden = true
            
        }
    }
    
   
 func checkMapTimes() {
    
    UserManager.shared.getUserData(completion: {data in
        
        guard let data = data else {return}
               
        if data.totalScore != nil {
               UserManager.totalScore =
                   data.totalScore!}
                 
           if data.mapPlayTime != nil {
                 
               let mapPlayTime = DateManager.timeStampToString(date:
                   data.mapPlayTime!)
               
               let currentTime = DateManager.dateToString(date:
                   Date())
         
           if mapPlayTime == currentTime {
               
               self.mapCouldTimes = 0
               self.isTodayMap()
               
              } else {
               
               self.mapCouldTimes = 1
               
              }
           } else {
               
             self.mapCouldTimes = 1
               
            }
         })

 }
    
    @objc func showResult(){
        let mapResult = result.randomElement()
       
        self.scratchCard?.isHidden = true
        self.firstButton.isHidden = true
        self.secondButton.isHidden = true
        self.thirdButton.isHidden = true
        self.forthButton.isHidden = true
        self.fifthButton.isHidden = true
        
        if mapResult == true {
            self.baseMapImage.image = UIImage(named: "getreward")
            changeText()
            saveMapRecord()
            updateMapData()
            
        } else {
            updateMapData()
            changeText()
            self.baseMapImage.image = UIImage(named: "unreward")
        }
    }
    
    func changeText() {
        mapchanceLabel.text = "您今日已無探索機會"
        mapTitleLabel.text = "請明日再來"
    }
    func updateMapData() {
        
        let updateData = ["totalScore": UserManager.totalScore + 2,
                          "mapPlayTime": FirebaseFirestore.Timestamp(date:Date())]
            as [String : Any]
        
        FireBaseHelper.updateData(update: updateData)
        
    }
    func saveMapRecord() {
        let scoreRecordData: [String: Any] = ["time":
            FirebaseFirestore.Timestamp(date:Date()) ,
             "score": 2,
             "source": "map" ]
        
        FireBaseHelper.saveUserRecord(saveData: scoreRecordData)
    }
    
    func scratchEnded(point: CGPoint) {
        print("End：\(point)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false

    }
}


