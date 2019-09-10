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
        
        self.navigationController?.popToRootViewController(animated: true)
    
    }
    
    @IBAction func goToRecordPage(_ sender: Any) {
   
//        let appdelegate = UIApplication.shared.delegate
//
//        let tabBarController = appdelegate?.window??.rootViewController as? UITabBarController

        self.tabBarController?.selectedIndex = 3

    }
    
    var mapCouldTimes: Int = 1
    
    var currewntProgress: String? = "當前探索進度：0%"{
        
        didSet{
              mapchanceLabel.text = self.currewntProgress
        }
    }
    
    let db = Firestore.firestore()
    
    let firstButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width * 49 / 414, y: UIScreen.main.bounds.height * 85 / 896, width: 40, height: 40))
    let secondButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width  * 225 / 414, y: UIScreen.main.bounds.height * 45 / 896, width: 40, height: 40))
    let thirdButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width * 158 / 414, y: UIScreen.main.bounds.height * 206 / 896, width: 40, height: 40))
    let forthButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width * 293 / 414, y: UIScreen.main.bounds.height * 300 / 896, width: 40, height: 40))
    let fifthButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width * 335 / 414, y: UIScreen.main.bounds.height * 265 / 896, width: 40, height: 40))
    
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
            self.view.bringSubviewToFront(self.baseMapImage)
            self.setButton()
      
        }
    }

    func setButton() {
        
        self.baseMapImage.isUserInteractionEnabled = true
        
                self.buttons = [self.firstButton, self.secondButton, self.thirdButton, self.forthButton, self.fifthButton]
                for button in self.buttons{
                    button.tag = index
                    button.showsTouchWhenHighlighted = true
                    button.setTitle("📌", for: .normal)
                    button.titleLabel?.font = .systemFont(ofSize: 25)
                    button.addTarget(self, action: #selector(self.showResult), for: .touchUpInside)
                    self.baseMapImage.addSubview(button)
                    index += 1
                }
        
    }
    
    func isTodayMap() {
        if mapCouldTimes == 0 {
            mapchanceLabel.text = "您今日已無探索機會"
            mapTitleLabel.text = "請明日再來"
            self.baseMapImage.image = UIImage(named: "nomap")
            view.bringSubviewToFront(self.baseMapImage)
    }
    }
    
   
 func checkMapTimes() {
        db.collection("user").document(Auth.auth().currentUser!.uid).getDocument { (document, error) in
            
            if let document = document, document.exists {
                print(document.documentID, document.data() as Any)
                
                if document.data()!["totalScore"] != nil {
                ProfileViewController.totalScore = document.data()!["totalScore"] as! Int
                }
                //轉換 Time 格式
                
                if document.data()!["mapPlayTime"] != nil {
                let timestamp = document.data()!["mapPlayTime"] as! Timestamp
                let converted = Date(timeIntervalSince1970: TimeInterval(timestamp.seconds) )
                
                let now:Date = Date()
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = NSTimeZone.local
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let mapPlayTime = dateFormatter.string(from: converted as Date)
                let currentTime = dateFormatter.string(from: now as Date)
                
                print(mapPlayTime)
                print(currentTime)
                
                if mapPlayTime == currentTime {
                    self.mapCouldTimes = 0
                    self.isTodayMap()
                } else {
                    self.mapCouldTimes = 1
                }
                } else {
                    self.mapCouldTimes = 1
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    @objc func showResult(){
        let mapResult = result.randomElement()
        let resultMap = UIImageView(frame: self.baseMapImage.frame)
        
        if mapResult == true {
            resultMap.image = UIImage(named: "getreward")
            mapchanceLabel.text = "您今日已無探索機會"
            mapTitleLabel.text = "請明日再來"
            
            let scoreRecordData: [String: Any] = ["mapPlayTime":FirebaseFirestore.Timestamp(date:Date()) ,"score": 2, "source": "map" ]
    
           //存用戶積分紀錄
            db.collection("user").document(Auth.auth().currentUser!.uid).collection("records").document().setData(scoreRecordData){ (error) in
                if let error = error {
                    print(error)
                }
            }
            //update用戶總積分
                db.collection("user").whereField("email", isEqualTo: Auth.auth().currentUser!.email ?? "no email").getDocuments { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    let document = querySnapshot.documents.first
                    document?.reference.updateData(["totalScore": ProfileViewController.totalScore + 2,"mapPlayTime": FirebaseFirestore.Timestamp(date:Date()) ], completion: { (error) in
                    })
                }
            }
            
        } else {
            //update用戶總積分
            db.collection("user").whereField("email", isEqualTo: Auth.auth().currentUser!.email ?? "no email").getDocuments { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    let document = querySnapshot.documents.first
                    document?.reference.updateData(["mapPlayTime": FirebaseFirestore.Timestamp(date:Date()) ], completion: { (error) in
                    })
                }
            }
            mapchanceLabel.text = "您今日已無探索機會"
            mapTitleLabel.text = "請明日再來"
            resultMap.image = UIImage(named: "unreward")
        }
        view.addSubview(resultMap)
        view.bringSubviewToFront(resultMap)
      
    }
    
    func scratchEnded(point: CGPoint) {
        print("End：\(point)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isToolbarHidden = false
        tabBarController?.tabBar.isHidden = false
    }
}


