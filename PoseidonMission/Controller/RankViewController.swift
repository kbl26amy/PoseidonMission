//
//  RankViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class RankViewController: PMBaseViewController  {
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    var fishGiveId: [String] = []
    var jellyGiveId: [String] = []
    var userRankData = UserData(email: "", name: "") {
        didSet {
           
            rankCollectionView.reloadData()
            print(userRankData)
        }
    }
    
    var fishRankData: [RankData] = []{
        didSet {
            rankTableView.delegate = self
            rankTableView.dataSource = self
            rankTableView.reloadData()
            loadingView.stopAnimating()
        }
    }
    var jellyRankData: [RankData] = [] {
        didSet {
            rankTableView.delegate = self
            rankTableView.dataSource = self
            rankTableView.reloadData()
        }
    }
    
    var sectionTitle = ["釣魚排行", "打水母排行"]
    var bannerImages = ["fishingPic", "jellyFishPic", "loginPic"]
    
    @IBOutlet weak var rankCollectionView: UICollectionView! {
        didSet{
            rankCollectionView.delegate = self
            rankCollectionView.dataSource = self
        }
    }
      
    
    lazy var bannerLayout: BannerCollectionViewLayout = {
        
        let layout = BannerCollectionViewLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 2 / 5,
                                 height: 145
        )
        return layout
    }()
    
    @IBOutlet weak var rankTableView: UITableView!
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.startAnimating()
        
        self.rankTableView.separatorStyle = .none
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UserManager.shared.getUserData(completion: {data in
            guard let data = data else {return}
            self.userRankData = data
 
            self.rankCollectionView.collectionViewLayout = self.bannerLayout
        })
        
        UserManager.shared.getFishHighestData(completion: {data in
            guard let data = data else {return}
            self.fishRankData = data
            
        })
        UserManager.shared.getJellyHighestData(completion: {data in
            guard let data = data else {return}
            self.jellyRankData = data
            
        })
    }
    
}
extension RankViewController: UICollectionViewDelegate,
UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int)
        -> Int {
    
            return bannerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            
            let cell = rankCollectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: RankCollectionViewCell.self),
                for: indexPath)
            guard let bannerCell = cell as? RankCollectionViewCell else { return cell }
        
            bannerCell.layer.cornerRadius = 6.0
            bannerCell.layer.borderWidth = 1.0
        
            bannerCell.layer.borderColor = UIColor.darkGray.cgColor
            bannerCell.layer.shadowColor = UIColor.gray.cgColor
            bannerCell.layer.shadowOffset = CGSize(width: 1, height: 3)
            bannerCell.layer.shadowRadius = 6.0
        
            bannerCell.bannerImage.image = UIImage(named: bannerImages[indexPath.row])
        
            var bannerLabelText = "尚無遊戲資料"
            switch indexPath.row {
            case 0: bannerLabelText = "最高積分：\(self.userRankData.fishingHighest ?? 0)"
            case 1: bannerLabelText = "最高積分：\(self.userRankData.jellyFishHighest ?? 0)"
            case 2: bannerLabelText = "登入次數：\(self.userRankData.loginCounts ?? 0)"
            default:
                bannerLabelText = "尚無遊戲資料"
            }
            bannerCell.bannerLabel.text = bannerLabelText
        
            return bannerCell
            
    }
    
}
    
extension RankViewController: UITableViewDelegate,
UITableViewDataSource{
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int)
        -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
        
        let cell = rankTableView.dequeueReusableCell(
            
            withIdentifier: String(describing: RankTableViewCell.self),
            for: indexPath)
        
        guard let rankCell = cell as? RankTableViewCell
            else { return cell }
            
        switch indexPath.section {
            
        case 0 :
            
            rankCell.rankData = self.fishRankData
            rankCell.giftRecord = self.userRankData.fishGiveId
                      
            rankCell.giftClosure = { cell, giftId in
                
                self.fishGiveId = giftId
                print("fish : \(self.fishGiveId)")
                
                let fishGiveIdData = ["fishGiveId": self.fishGiveId]
                FireBaseHelper.updateData(update: fishGiveIdData)
                let getGift = ["getGift": 1]
                for userid in self.fishGiveId{
                    FireBaseHelper.updateOtherData(other:
                        userid, update: getGift)
                }
            }
        case 1 :
            
            rankCell.rankData = self.jellyRankData
            rankCell.giftRecord = self.userRankData.jellyGiveId
        
            rankCell.giftClosure = { cell, giftId in
                
                self.jellyGiveId = giftId
                print("jellyfish : \(self.jellyGiveId)")
                
                let jellyGiveIdData = ["jellyGiveId": self.jellyGiveId]
                FireBaseHelper.updateData(update: jellyGiveIdData)
                let getGift = ["getGift": 1]
                for userid in self.fishGiveId{
                    FireBaseHelper.updateOtherData(other:
                        userid, update: getGift)
                }
            }
            
        default:
            print("error")
            
        }
        return rankCell
        
    }
    
    func numberOfSections(in tableView: UITableView)
        -> Int {
        return sectionTitle.count
    }

    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int)
        -> UIView? {
        
        let headerView = UIView()
        
        headerView.frame = CGRect(x: 0, y: 0,
                                  width: tableView.frame.width,
                                  height: 40)
            
        headerView.backgroundColor = UIColor.clear
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.darkGray
        titleLabel.text = sectionTitle[section]
        titleLabel.frame = CGRect(x: 16, y: 0,
                                  width: tableView.frame.width,
                                  height: 40)
            
        headerView.addSubview(titleLabel)
        
//        let seeRecord = UIButton()
//        seeRecord.frame = CGRect(x: tableView.frame.width - tableView.frame.width / 5,
//                                 y: 0, width: tableView.frame.width / 5, height: 50)
//        seeRecord.setTitle("查看全部", for: .normal)
//        seeRecord.setTitleColor(UIColor(red: 147/255, green: 208/255,
//                                        blue: 218/255, alpha: 1),
//                                for: .normal)
//        seeRecord.titleLabel?.font = .systemFont(ofSize: 14)
//        
//        headerView.addSubview(seeRecord)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int)
        -> CGFloat {
        return 40
    }
    
  
}
