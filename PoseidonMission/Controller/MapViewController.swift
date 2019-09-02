//
//  MapViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

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
    
    let firstButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width * 51 / 414, y: UIScreen.main.bounds.height * 88 / 896, width: 40, height: 40))
    let secondButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width  * 225 / 414, y: UIScreen.main.bounds.height * 56 / 896, width: 40, height: 40))
    let thirdButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width * 156 / 414, y: UIScreen.main.bounds.height * 219 / 896, width: 40, height: 40))
    let forthButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width * 295 / 414, y: UIScreen.main.bounds.height * 311 / 896, width: 40, height: 40))
    let fifthButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width * 334 / 414, y: UIScreen.main.bounds.height * 277 / 896, width: 40, height: 40))
    
    var buttons: [UIButton] = []
    var index = 0
    var imageNames : [String] = ["unreward", "unreward", "unreward", "getreward", "getreward"]
    
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
        
        if progress >= 0.1 {
        
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
//                    button.backgroundColor = .orange
                    button.layer.cornerRadius = 20
                    button.showsTouchWhenHighlighted = true
                    button.setTitle("📌", for: .normal)
                    button.addTarget(self, action: #selector(self.showResult), for: .touchUpInside)
                    self.baseMapImage.addSubview(button)
                    index += 1
                }
        
    }
    
    @objc func showResult(){
        var imageNumber = Int.random(in: 0...4)
        let resultMap = UIImageView(frame: self.baseMapImage.frame)
        
        resultMap.image = UIImage(named: imageNames[imageNumber])
        if imageNumber == 4{
            imageNumber = 0
        } else {
            imageNumber += 1
        }
        view.addSubview(resultMap)
        view.bringSubviewToFront(resultMap)
      
    }
    
    func scratchEnded(point: CGPoint) {
        print("End：\(point)")
    }
    
}
