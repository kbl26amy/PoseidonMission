//
//  RankViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class RankViewController: PMBaseViewController  {

    var bannerImages = ["FishingRank", "JellyRank", "LoginRank" ]
    
    @IBOutlet weak var rankCollectionView: UICollectionView!{
        didSet{
            rankCollectionView.delegate = self
            rankCollectionView.dataSource = self
        }
    }
    
    lazy var cardLayout: FlatCardCollectionViewLayout = {
        let layout = FlatCardCollectionViewLayout()
        layout.itemSize = CGSize(width: rankCollectionView.contentSize.width, height: rankCollectionView.contentSize.height)
        return layout
    }()
    
    @IBOutlet weak var rankTableView: UITableView!{
        didSet{
            rankTableView.delegate = self
            rankTableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rankCollectionView.collectionViewLayout = cardLayout
    }
}
extension RankViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60)
        headerView.backgroundColor = UIColor.white
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.text = "釣魚高手"
        titleLabel.frame = CGRect(x: 16, y: 8, width: tableView.frame.width, height: 50)
        headerView.addSubview(titleLabel)
        
        let seeRecord = UIButton()
        seeRecord.frame = CGRect(x: tableView.frame.width - tableView.frame.width / 5, y: 8, width: tableView.frame.width / 5, height: 50)
        seeRecord.setTitle("查看全部", for: .normal)
      seeRecord.setTitleColor(UIColor(red: 147/255, green: 208/255, blue: 218/255, alpha: 1), for: .normal)
        seeRecord.titleLabel?.font = .systemFont(ofSize: 14)
        
        headerView.addSubview(seeRecord)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = rankCollectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: RankCollectionViewCell.self),
            for: indexPath)
        guard let bannerCell = cell as? RankCollectionViewCell else { return cell }
        
        bannerCell.layer.cornerRadius = 6.0
        bannerCell.layer.borderWidth = 1.0
        bannerCell.layer.borderColor = UIColor.clear.cgColor
        bannerCell.layer.shadowColor = UIColor.gray.cgColor
        bannerCell.layer.shadowOffset = CGSize(width: 0, height: 3)
        bannerCell.layer.shadowRadius = 6.0
        
        bannerCell.bannerImage.image = UIImage(named: bannerImages[indexPath.row])
        
        return bannerCell
    }
    
    
    
}
extension RankViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = rankTableView.dequeueReusableCell(
            withIdentifier: String(describing: RankTableViewCell.self),
            for: indexPath)
        
        guard let rankCell = cell as? RankTableViewCell else { return cell }
        rankCell.userImage.image = UIImage(named: "profile")
        
        return rankCell
     
    }
  
}
