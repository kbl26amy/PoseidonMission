//
//  FishManager.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/13.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import UIKit

protocol FishGenerator {
    
    func fetchFishImageView() -> UIImageView
}

extension FishGenerator {
    
    func randomFishImage() -> UIImageView? {
        
        let fishs = ["fish1", "fish2", "fish3", "fish4", "fish5", "fish6", "fish7", "fish8", "fish9"]
        
        let fishImageView = UIImageView(image:  UIImage(named: fishs.randomElement()!))
        
        return fishImageView
    }
}

struct PathOne: FishGenerator {
    
    func fetchFishImageView() -> UIImageView {
        let fish = randomFishImage()
        fish?.frame = CGRect(x: -60, y: 300, width: 40, height: 30)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 11, delay: 0, animations: {
            fish?.frame.origin.x = UIScreen.main.bounds.size.width
         
            fish?.frame.origin.y = UIScreen.main.bounds.size.height / 2
            
        }, completion: nil)
     
        return fish!
    }
}


struct PathTwo: FishGenerator {
    
    func fetchFishImageView() -> UIImageView {
       let fish = randomFishImage()
        
        fish?.frame = CGRect(x: -60, y: 450, width: 60, height: 40)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 12, delay: 0, animations: {
            fish?.frame.origin.x = UIScreen.main.bounds.size.width
            
            fish?.frame.origin.y = UIScreen.main.bounds.size.height / 4
            
        }, completion: nil)
        
        return fish!
    }
}

struct PathThree: FishGenerator {
    
    func fetchFishImageView() -> UIImageView {
       let fish = randomFishImage()
        
        fish?.frame = CGRect(x: -60, y: 200, width: 70, height: 40)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 10, delay: 0, animations: {
            fish?.frame.origin.x = UIScreen.main.bounds.size.width
            
            fish?.frame.origin.y = UIScreen.main.bounds.size.height / 7
            
        }, completion: nil)
        
        return fish!
    }
}

struct PathForth: FishGenerator {
    
    func fetchFishImageView() -> UIImageView {
        let fish = randomFishImage()
        
        fish?.frame = CGRect(x: -60, y: 50, width:30, height: 20)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 15, delay: 0, animations: {
            fish?.frame.origin.x = UIScreen.main.bounds.size.width
            
            fish?.frame.origin.y = UIScreen.main.bounds.size.height / 5
            
        }, completion: nil)
        
        return fish!
    }

}

struct PathFifth: FishGenerator {
    
    func fetchFishImageView() -> UIImageView {
        let fish = randomFishImage()
        
        fish?.frame = CGRect(x: -60, y: 350, width: 60, height: 30)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 6, delay: 0, animations: {
            fish?.frame.origin.x = UIScreen.main.bounds.size.width
            
            fish?.frame.origin.y = UIScreen.main.bounds.size.height / 2
            
        }, completion: nil)
        
        return fish!
    }
}
