//
//  MapViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import Firebase

class MapViewController: UIViewController {

    @IBOutlet weak var mapBackground: UIImageView!
    
    @IBOutlet weak var mapTitleLabel: UILabel!
    
    @IBOutlet weak var mapchanceLabel: UILabel!
    
    @IBOutlet weak var baseMapImage: UIImageView!
    
    @IBOutlet weak var seeRecordButton: UIButton!
    
    @IBOutlet weak var leaveOutlet: UIButton!
    
    @IBAction func leaveButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
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
        
        navigationController?.isNavigationBarHidden = true
        mapTitleLabel.adjustsFontSizeToFitWidth = true
        self.mapBackground.image = UIImage(named: "mapbackground")
        self.baseMapImage.image = UIImage(named: "showmap")
        
        self.leaveOutlet.layer.cornerRadius = 20
        self.seeRecordButton.layer.cornerRadius = 20
        showMap()
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
        
        let percent = String(format: "%.1f", progress * 100)
        print("Finish：\(percent)%")
        
        if progress >= 0.7 {
        
            mapTitleLabel.text = "請選擇你要航行的地點"
            
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
    
    @objc func showResult(){
        let mapResult = result.randomElement()
        let resultMap = UIImageView(frame: self.baseMapImage.frame)
        
        if mapResult == true {
           resultMap.image = UIImage(named: "getreward")
            
            let db = Firestore.firestore()
            
            let playTimesData: [String: Any] = ["mapPlayTime": Firebase.ServerTimestampBehavior.self ,"mapTimes": 1 ]
            
            let scoreRecordData: [String: Any] = ["mapPlayTime": Firebase.ServerTimestampBehavior.self ,"score": 2, "source": "map" ]
            
             db.collection("user").document(Auth.auth().currentUser!.uid).setData(playTimesData) { (error) in
                if let error = error {
                    print(error)
                }
            }
            db.collection("user").document(Auth.auth().currentUser!.uid).collection("map").document().setData(scoreRecordData){ (error) in
                if let error = error {
                    print(error)
                }
            }
            
                db.collection("user").whereField("email", isEqualTo: Auth.auth().currentUser!.email ?? "no email").getDocuments { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    let document = querySnapshot.documents.first
                    document?.reference.updateData(["totalScore": 2], completion: { (error) in
                    })
                }
            }
            
        } else {
           resultMap.image = UIImage(named: "unreward")
        }
        view.addSubview(resultMap)
        view.bringSubviewToFront(resultMap)
      
    }
    
    func scratchEnded(point: CGPoint) {
        print("End：\(point)")
    }
    
}
