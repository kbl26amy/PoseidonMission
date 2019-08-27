//
//  ViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/26.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class LobbyViewController: PMBaseViewController {
    @IBOutlet weak var bannerCollectionView: UICollectionView!{
        didSet{
            bannerCollectionView.delegate = self
            bannerCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var homeCollectionView: UICollectionView!{
        didSet{
            homeCollectionView.delegate = self
            homeCollectionView.dataSource = self
        }
    }
    
    var homeCollectionImages = ["logintoday", "friend", "map", "fish", "watermother"]
    
    var homeCollectionLabel = ["簽到", "邀請好友", "藏寶圖", "釣魚", "打水母"]
    
    var homeCollectionLabelColor = [UIColor(red: 249/255, green: 97/255, blue: 43/255, alpha: 1),
                                    UIColor(red: 255/255, green: 181/255, blue: 37/255, alpha: 1),
                                    UIColor(red: 127/255, green: 197/255, blue: 0, alpha: 1),
                                    UIColor(red: 139/255, green: 152/255, blue: 206/255, alpha: 1),
                                    UIColor(red: 0, green: 188/255, blue: 232/255, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionViewLayout()
        
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        homeCollectionView.contentInset = UIEdgeInsets(top: (homeCollectionView.contentSize.height) / 5 , left: 0, bottom: 0, right: 0)
        
    }

}

extension LobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == homeCollectionView {
            return homeCollectionLabel.count
        } else {
            return homeCollectionImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if collectionView == homeCollectionView {
        let cell = homeCollectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: HomeCollectionViewCell.self),
                for: indexPath)
    
        guard let homeCell = cell as? HomeCollectionViewCell else { return cell }
        homeCell.homeCollectionViewImage.image = UIImage(named:  homeCollectionImages[indexPath.row])
        homeCell.homeCollectonViewLabel.text = homeCollectionLabel[indexPath.row]
        homeCell.homeCollectonViewLabel.textColor = homeCollectionLabelColor[indexPath.row]
        
        return homeCell
        } else {
        let cell = bannerCollectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: BannerCollectionViewCell.self),
                for: indexPath)
        guard let bannerCell = cell as? BannerCollectionViewCell else { return cell }
            bannerCell.bannerImages.image = UIImage(named:  homeCollectionImages[indexPath.row])
            
            return bannerCell
        }
      
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == homeCollectionView {
        switch indexPath.row {
            
        case 0:
            guard let mapController =  UIStoryboard.mission.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else {return}
            
            self.navigationController?.pushViewController(mapController, animated: true)
            
        case 4:
            guard let jellyfishController =  UIStoryboard.mission.instantiateViewController(withIdentifier: "JellyfishViewController") as? JellyfishViewController else {return}
            
            self.navigationController?.pushViewController(jellyfishController, animated: true)
            
        case 2:
            guard let missionController =  UIStoryboard.mission.instantiateViewController(withIdentifier: "MissionViewController") as? MissionViewController else {return}
            
            self.navigationController?.pushViewController(missionController, animated: true)
            
        case 3:
            guard let fishingController =  UIStoryboard.mission.instantiateViewController(withIdentifier: "FishingViewController") as? FishingViewController else {return}
            
            self.navigationController?.pushViewController(fishingController, animated: true)
            
        case 1:
            guard let loginTodayController =  UIStoryboard.mission.instantiateViewController(withIdentifier: "LoginTodayViewController") as? LoginTodayViewController else {return}
            
            self.navigationController?.pushViewController(loginTodayController, animated: true)
        default:
            guard let missionController =  UIStoryboard.mission.instantiateViewController(withIdentifier: "MissionViewController") as? MissionViewController else {return}
            
            self.navigationController?.pushViewController(missionController, animated: true)
        }
        }
    }
    
    
    
    
    
}
