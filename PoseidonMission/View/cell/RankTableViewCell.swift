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

    var likeRecord: [Bool]  = {
        
        var array: [Bool] = []
        
        for i in 0...1000 {
            array.append(false)
        }
        
        return array
    }()
    var rankData:[RankData] = [] {
        didSet{
            contentCollectionView.reloadData()
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
        
            contentCollectionView.delegate = self
            contentCollectionView.dataSource = self
        
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
        print(self.rankData.count)
        return self.rankData.count
    
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = contentCollectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ContentCollectionViewCell.self),
            for: indexPath)
        
        guard let contentCell = cell as? ContentCollectionViewCell else { return cell }
        
//            contentCell.userImage.image = UIImage(named: "profile")
        contentCell.rankNumber.text = "\(indexPath.row + 1)"
        contentCell.rankNumber.layer.cornerRadius = contentCell.rankNumber.frame.width / 2
            contentCell.rankNumber.backgroundColor = UIColor(red: 157/255, green: 215/255, blue: 229/255, alpha: 1)
            contentCell.userName.text = self.rankData[indexPath.row].name
            contentCell.userScore.text = "最高積分：\(self.rankData[indexPath.row].fishHighest)"
        
        contentCell.likeClosure = { cell in
            
            self.likeRecord[indexPath.row] = true
            
        }
        
        if self.likeRecord[indexPath.row]{
            contentCell.clickGoodButton.setImage(UIImage(named: "clickGood"), for: .normal)
        } else {
            contentCell.clickGoodButton.setImage(UIImage(named: "unClickGood"), for: .normal)
        }

            return contentCell
    }
  
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
     
         self.contentCollectionView.collectionViewLayout = cardLayout
    }

}
    

