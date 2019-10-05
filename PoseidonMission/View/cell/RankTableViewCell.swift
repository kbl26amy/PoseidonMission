//
//  RankTableViewCell.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/9.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import NVActivityIndicatorView

class RankTableViewCell: UITableViewCell {
    
    var currentId = ""
    var giveId: [String] = [] {
            didSet{
                contentCollectionView.reloadData()
            }
        }
 
    var giftClosure: ((ContentCollectionViewCell, [String], String) -> ())?
    
    var rankData:[RankData] = [] {
        didSet{
            contentCollectionView.reloadData()
        }
    }
    @IBOutlet weak var userRecord: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    lazy var cardLayout: PageCollectionViewLayout = {
        
        let layout = PageCollectionViewLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 4 / 5,
                                 height: 60)
        return layout
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
    self.contentCollectionView.collectionViewLayout = cardLayout
        
    }
    
    @IBOutlet weak var contentCollectionView: UICollectionView! {
        didSet{
            self.contentCollectionView.reloadData()
        }
    }
}

extension RankTableViewCell: UICollectionViewDelegate,
UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView)
        -> Int {
            return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int)
        -> Int {
            return self.rankData.count
            
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            
            let cell = contentCollectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing:
                    ContentCollectionViewCell.self),
                for: indexPath)
            
            guard let contentCell = cell as? ContentCollectionViewCell
                else { return cell }
            
            contentCell.rankNumber.text =
            "\(indexPath.row + 1)"
            
            contentCell.userImage.layer.cornerRadius = collectionView
                .frame
                .width / 48 * 3
            
            contentCell.userImage.layer.borderColor = .init(srgbRed: 98/255,
                                                            green: 97/255,
                                                            blue: 95/255,
                                                            alpha: 1)
            contentCell.userImage.layer.borderWidth = 1
            
            contentCell.userName.text = self.rankData[indexPath.row].name
            
            contentCell.userScore.text = "最高積分：\(self.rankData[indexPath.row].highest)"
            
            if (self.rankData[indexPath.row].photo != nil) {
                let url = URL(string: (self.rankData[indexPath.row].photo)!)
                contentCell.userImage.kf.setImage(with: url)
                
            } else {
                contentCell.userImage.image = UIImage.asset(.ship)
            }
            
            contentCell.likeClosure = { [weak self] cell in
                
                contentCell.giftButton.isEnabled = false
                contentCell.giftButton.setBackgroundImage(
                    UIImage(systemName: "gift.fill"), for: .normal)
                contentCell.giftButton.tintColor = UIColor.darkBlue
                
                guard let strongSelf = self else { return }
                strongSelf.giveId.append(strongSelf.rankData[indexPath.row].userId)
                
                strongSelf.currentId = strongSelf.rankData[indexPath.row].userId
                
                strongSelf.giftClosure!(contentCell, strongSelf.giveId, strongSelf.currentId )
            }

            if giveId != [] {
               
                if giveId.contains(rankData[indexPath.row].userId) {
                    contentCell.giftButton.isEnabled = false
                    contentCell.giftButton.setBackgroundImage(
                        UIImage(systemName: "gift.fill"), for: .normal)
                    contentCell.giftButton.tintColor = UIColor.darkBlue
                } else {
                    contentCell.giftButton.isEnabled = true
                    contentCell.giftButton.setBackgroundImage(
                        UIImage(systemName:
                        "gift"), for: .normal)
                    contentCell.giftButton.tintColor =
                        UIColor.darkGray
                }
            } else {
                contentCell.giftButton.isEnabled = true
                contentCell.giftButton.setBackgroundImage(
                    UIImage(systemName:
                    "gift"), for: .normal)
                contentCell.giftButton.tintColor =
                    UIColor.darkGray
            }
            return contentCell
    }

}
