//
//  RankTableViewCell.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/9.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import Firebase
class RankTableViewCell: UITableViewCell {

    var fishRankData: [FishRank] = []{
        didSet {
            contentCollectionView.delegate = self
            contentCollectionView.dataSource = self
            contentCollectionView.reloadData()
            print(fishRankData)
        }
    }
    var jellyRankData: [JellyRank] = [] {
        didSet {
            contentCollectionView.delegate = self
            contentCollectionView.dataSource = self
            contentCollectionView.reloadData()
            print(jellyRankData)
        }
    }
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var userRecord: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    lazy var cardLayout: PageCollectionViewLayout = {
        
        let layout = PageCollectionViewLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 18 / 20,
                                 height: contentCollectionView.bounds.height / 3 - 10)
        return layout
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UserManager.shared.getFishHighestData(completion: {data in
            guard let data = data else {return}
            self.fishRankData = data
            
        })
        UserManager.shared.getJellyHighestData(completion: {data in
            guard let data = data else {return}
            self.jellyRankData = data
            
        })
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBOutlet weak var contentCollectionView: UICollectionView!

}
extension RankTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0{
            return self.fishRankData.count
        } else {
            return self.jellyRankData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = contentCollectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ContentCollectionViewCell.self),
            for: indexPath)
        
        guard let contentCell = cell as? ContentCollectionViewCell else { return cell }
        
        switch indexPath.section {
        
        case 0 :
           
            contentCell.userImage.image = UIImage(named: "profile")
            contentCell.userName.text = self.fishRankData[indexPath.row].name
            contentCell.userScore.text = "\(self.fishRankData[indexPath.row].fishHighest)"
       
           
        case 1 :
          
            contentCell.userImage.image = UIImage(named: "profile")
            contentCell.userName.text = self.jellyRankData[indexPath.row].name
            contentCell.userScore.text = "\(self.jellyRankData[indexPath.row].jellyHighest)"
       
        default:
        print("error")
       
        }
            return contentCell
    }
  
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
     
         self.contentCollectionView.collectionViewLayout = cardLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
       
    }
}
    

