//
//  ViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/26.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import FirebaseAuth


class LobbyViewController: PMBaseViewController {
    var headerTitles = ["熱門遊戲", "每日任務"]
    var fishRankData: [RankData] = []{
        didSet{
        runLightViewLabel.text =
            "恭喜玩家：\(self.fishRankData.first?.name ?? "")獲得釣魚高手排行第一名"
            bannerCollectionView.delegate = self
            bannerCollectionView.dataSource = self
            bannerCollectionView.reloadData()
        }
    }
    var jellyRankData: [RankData] = []{
        didSet{
        runLightViewLabel.text =
            "恭喜玩家：\(self.jellyRankData.first?.name ?? "")獲得打水母排行第一名"
            bannerCollectionView.delegate = self
            bannerCollectionView.dataSource = self
            bannerCollectionView.reloadData()
        }
    }
    
    var loginRankData: [RankData] = []{
        didSet{
            bannerCollectionView.delegate = self
            bannerCollectionView.dataSource = self
            bannerCollectionView.reloadData()
        }
    }
    @IBOutlet weak var runLightView: UIView!
    @IBOutlet weak var logoutOulet: UIBarButtonItem!
    @IBOutlet weak var showRegisterButtonOutlet: UIButton!
    @IBAction func logOutAction(_ sender: Any) {
        print("logout")
       
            if KeyChainManager.shared.get("userid") != nil {
                do {
                    try KeyChainManager.shared.delete("userid")
                    showRegisterButtonOutlet.isHidden = false
                    logoutOulet.isEnabled = false
                    logoutOulet.tintColor = .white
                    runLightViewLabel.alpha = 0
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
    }
 
    
    @IBOutlet weak var runLightViewLabel: UILabel!
    
    func runlight () {
        
        self.runLightView.backgroundColor = UIColor.clear
        
        var frame = runLightViewLabel.frame
        frame.origin.x = UIScreen.main.bounds.width
        runLightViewLabel.frame = frame
        UIView.beginAnimations("testAnimation", context: nil)
        UIView.setAnimationDuration(20.8)
        UIView.setAnimationCurve(.linear)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationRepeatAutoreverses(false)
        UIView.setAnimationRepeatCount(999999)
        frame = runLightViewLabel.frame
        frame.origin.x = -UIScreen.main.bounds.width * 5
        runLightViewLabel.frame = frame
        UIView.commitAnimations()
    
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        
        guard let loginViewController = UIStoryboard.auth.instantiateInitialViewController()
            else { return }
        
        loginViewController.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(loginViewController, animated: true)

        
    }
    
    lazy var cardLayout: FlatCardCollectionViewLayout = {
        let layout = FlatCardCollectionViewLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 3 / 5 , height: homeCollectionView.contentSize.height)
        return layout
    }()
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
        {
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
    
    var bannerImages = ["FishingRank", "JellyRank", "LoginRank" ]
    
    var homeCollectionImages = [ "map", "fishing", "jellyFish", "loginToday", "share"]
    
    var homeCollectionLabel = [ "藏寶圖", "釣魚", "打水母", "簽到", "邀請好友"]
    
    var homeCollectionLabelColor = [
                                    UIColor(red: 127/255, green: 197/255, blue: 0, alpha: 1),
                                    UIColor(red: 139/255, green: 152/255, blue: 206/255, alpha: 1),
                                    UIColor(red: 0, green: 188/255, blue: 232/255, alpha: 1),
                                    UIColor(red: 249/255, green: 97/255, blue: 43/255, alpha: 1),
                                    UIColor(red: 255/255, green: 181/255, blue: 37/255, alpha: 1)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupCollectionViewLayout()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UserManager.shared.getFishHighestData(completion: {data in
            guard let data = data else {return}
            self.fishRankData = data
            
        })
        UserManager.shared.getJellyHighestData(completion: {data in
            guard let data = data else {return}
            self.jellyRankData = data
            
        })
        UserManager.shared.getLoginHighestData(completion: {data in
            guard let data = data else {return}
            self.loginRankData = data
            print(self.loginRankData)
        })
         navigationController?.isNavigationBarHidden = false
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
       
        homeCollectionView.contentInset = UIEdgeInsets(top: (homeCollectionView.contentSize.height) / 5 ,
                                                       left: 0, bottom: 0, right: 0)
        self.bannerCollectionView.collectionViewLayout = cardLayout
 
        if KeyChainManager.shared.get("userid") != nil {
            runLightViewLabel.alpha = 1
            runlight ()
            showRegisterButtonOutlet.isHidden = true
            logoutOulet.isEnabled = true
            logoutOulet.tintColor = .white
        } else {
            logoutOulet.isEnabled = false
            logoutOulet.tintColor = UIColor(red: 131.0/255.0, green: 211.0/255.0,
                                            blue: 222.0/255.0, alpha: 1.0)
            runLightViewLabel.alpha = 0
        }
    }

}


extension LobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    
        if collectionView == homeCollectionView {
        if kind == UICollectionView.elementKindSectionHeader {

            let header = collectionView.dequeueReusableSupplementaryView(
                      ofKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: String(describing: LobbyCollectionReusableView.self),
                      for: indexPath
                  )

            guard let headerView = header as? LobbyCollectionReusableView else { return header }

            view.layoutIfNeeded()
            headerView.headerTitle.text = headerTitles[indexPath.row]
                  return headerView
                }
        }
        
        return UICollectionReusableView()
  }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == homeCollectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: 40.0)
        }
        return CGSize(width: 0, height: 0)
    }
    

    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == homeCollectionView {
            return homeCollectionLabel.count
        } else {
            return bannerImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        if collectionView == homeCollectionView {
            let cell = homeCollectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: HomeCollectionViewCell.self),
                for: indexPath)
    
        guard let homeCell = cell as? HomeCollectionViewCell else { return cell }
        homeCell.homeCollectionViewImage.image = UIImage(named: homeCollectionImages[indexPath.row])
        homeCell.homeCollectonViewLabel.text = homeCollectionLabel[indexPath.row]
        homeCell.homeCollectonViewLabel.textColor = homeCollectionLabelColor[indexPath.row]
        
        return homeCell
            
        } else {
            
        let cell = bannerCollectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: BannerCollectionViewCell.self),
                for: indexPath)
        guard let bannerCell = cell as? BannerCollectionViewCell else { return cell }
            
            bannerCell.bannerImages.image = UIImage(named: "champion")
            
            var title = ""
            var iconName = ""
            var championName = ""
            var championScore = ""
            
            switch indexPath.row {
            case 0: title = "釣魚總冠軍"
                    iconName = "fishingPic"
                   championName = "暱稱：\( self.fishRankData.first?.name ?? "無排行")"
            championScore =  "最高積分：\(self.fishRankData.first?.highest ?? 0)"
            case 1: title = "打水母冠軍"
                    iconName = "jellyFishPic"
                    championName = "暱稱：\(self.jellyRankData.first?.name ?? "無排行")"
            championScore =  "最高積分：\(self.jellyRankData.first?.highest ?? 0)"
            case 2: title = "簽到總冠軍"
                    iconName = "loginPic"
            championName = "暱稱：\(self.loginRankData.first?.name ?? "無排行")"
            championScore =  "登入天數：\(self.loginRankData.first?.highest ?? 0)"
                
            default:
                title = "冠軍排行"
            }
            bannerCell.bannerTitle.text = title
            bannerCell.iconImage.image = UIImage(named: iconName)
            bannerCell.nameLabel.text = championName
            bannerCell.rankScore.text = championScore
           
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

    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let goStoryViewController = UIStoryboard
            .mission
            .instantiateViewController(withIdentifier: "StoryViewController")
            as! StoryViewController
        
        if KeyChainManager.shared.get("userid") != nil {
            
        if collectionView == homeCollectionView {

        switch indexPath.row {
            
        case 0:
            goStoryViewController.storyText = StoryContent.mapStory
              goStoryViewController.targetText = StoryContent.mapTarget
            
              self.navigationController?.pushViewController(goStoryViewController,
                                                            animated: true)
        case 1:
            
            goStoryViewController.storyText = StoryContent.fishingStory
            goStoryViewController.targetText = StoryContent.fishingTarget
            
            self.navigationController?.pushViewController(goStoryViewController,
                                                          animated: true)
        case 2:
            goStoryViewController.storyText = StoryContent.jellyFishStory
                goStoryViewController.targetText = StoryContent.jellyFishTarget
            
                self.navigationController?.pushViewController(goStoryViewController,
                                                              animated: true)
        case 3:
            
            let loginTodayController = UIStoryboard
                .mission
                .instantiateViewController(withIdentifier: "LoginTodayViewController")
                as! LoginTodayViewController
            loginTodayController.modalPresentationStyle = .overCurrentContext
            loginTodayController.modalTransitionStyle = .crossDissolve
            present(loginTodayController, animated: true, completion: nil)
            
            
        case 4:
            ShareManager.checkIsShareToday(sender: self)
            
        default:
            print("no view")
            
            }
            }
            
        }else {
            guard let loginViewController = UIStoryboard
                                            .auth
                                            .instantiateInitialViewController()
                else { return }
            
            loginViewController.modalPresentationStyle = .overFullScreen
            
            navigationController?.pushViewController(loginViewController, animated: true)
        }
}
}
