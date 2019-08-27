//
//  ViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/26.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class LobbyViewController: PMBaseViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!{
        didSet{
            homeCollectionView.delegate = self
            homeCollectionView.dataSource = self
        }
    }
    
    var homeCollectionImages = ["logintoday", "friend", "map", "fish", "watermother"]
    
    var homeCollectionLabel = ["簽到", "邀請好友", "藏寶圖", "釣魚", "打水母"]
    
    var homeCollectionLabelColor = [
                                    UIColor(red: 249/255, green: 97/255, blue: 43/255, alpha: 1),
                                    UIColor(red: 255/255, green: 181/255, blue: 37/255, alpha: 1),
                                    UIColor(red: 127/255, green: 197/255, blue: 0, alpha: 1),
                                    UIColor(red: 139/255, green: 152/255, blue: 206/255, alpha: 1),
                                    UIColor(red: 0, green: 188/255, blue: 232/255, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionViewLayout()
        

    
    }


}

extension LobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeCollectionLabel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: HomeCollectionViewCell.self),
            for: indexPath
        )
        
        guard let homeCell = cell as? HomeCollectionViewCell else { return cell }
        
        homeCell.homeCollectionViewImage.image = UIImage(named:  homeCollectionImages[indexPath.row])
        homeCell.homeCollectonViewLabel.text = homeCollectionLabel[indexPath.row]
        homeCell.homeCollectonViewLabel.textColor = homeCollectionLabelColor[indexPath.row]
        return homeCell
    }
    
    private func setupCollectionViewLayout() {
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSize(
            width: Int(UIScreen.main.bounds.width / 4) ,
            height: Int(UIScreen.main.bounds.width / 4)
        )
        
        flowLayout.minimumInteritemSpacing = 0
        
        flowLayout.minimumLineSpacing = 0.0
        
        homeCollectionView.collectionViewLayout = flowLayout
    }
    
    
    
    
    
}
