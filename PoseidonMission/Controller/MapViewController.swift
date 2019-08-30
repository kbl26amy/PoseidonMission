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
    
    @IBOutlet weak var seeRuleButton: UIButton!
    
    var resultImage : UIImageView?
    var scratchImage : ScratchMask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true

        self.mapBackground.image = UIImage(named: "mapbackground")
        
        self.baseMapImage.image = UIImage(named: "showmap")
        
        self.seeRuleButton.setImage(UIImage(named: "redbutton"), for: .normal)
        
        self.seeRecordButton.setImage(UIImage(named: "orangebutton"), for: .normal)
        
        showMap()
    }
    
    func showMap(){
        
        let scratchCard = ScratchCard(frame: self.baseMapImage.frame,
                                      mapImage: UIImage(named: "showmap")!,
                                      maskImage: UIImage(named: "unmap")!)
        
        view.addSubview(scratchCard)
        view.bringSubviewToFront(scratchCard)
        scratchCard.delegate = self
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
        
        if progress >= 0.8 {
        
            mapTitleLabel.text = "請選擇你要航行的地點"
            
            DispatchQueue.main.async {
            
            let firstButton = UIButton(frame: CGRect(x: 51, y: 93, width: 30, height: 30))
            let secondButton = UIButton(frame: CGRect(x: 225, y: 56, width: 30, height: 30))
            let thirdButton = UIButton(frame: CGRect(x: 156, y: 219, width: 30, height: 30))
            let forthButton = UIButton(frame: CGRect(x: 295, y: 311, width: 30, height: 30))
            let fifthButton = UIButton(frame: CGRect(x: 334, y: 277, width: 30, height: 30))
            
            firstButton.backgroundColor = .orange
            secondButton.backgroundColor = .orange
            thirdButton.backgroundColor = .orange
            forthButton.backgroundColor = .orange
            fifthButton.backgroundColor = .orange
            
            self.baseMapImage.addSubview(firstButton)
            self.baseMapImage.addSubview(secondButton)
            self.baseMapImage.addSubview(thirdButton)
            self.baseMapImage.addSubview(forthButton )
            self.baseMapImage.addSubview(fifthButton)
            self.view.bringSubviewToFront(self.baseMapImage)
                
            self.loadViewIfNeeded()
                
             let buttons = [firstButton, secondButton, thirdButton, forthButton, fifthButton]
               
                var index = 0
                for button in buttons{
                    button.tag = index
                    button.addTarget(self, action: #selector(self.showResult), for: UIControl.Event.touchUpInside)
                    index += 1
                }
              
            }
        }
    }
    
    
    @objc func showResult(){
        let resultMap = UIImageView(frame: self.baseMapImage.frame)
        resultMap.image = UIImage(named: "unreward")
        view.addSubview(resultMap)
        view.bringSubviewToFront(resultMap)
    }
    
    func scratchEnded(point: CGPoint) {
        print("End：\(point)")
    }
    
}
