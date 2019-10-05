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
    
    var timer:Timer?
    var headerTitles = ["熱門推薦"]
    var rankList = Champion(item: [
        ChampionList.fishing,
        ChampionList.jellyFish,
        ChampionList.login
    ])
    var hotItems = HotItemList(item: [
        Hots.map, Hots.fishing, Hots.jellyFish,
        Hots.loginToday, Hots.invite
    ])
    
    @IBOutlet weak var runLightView: UIView!
    @IBOutlet weak var logoutOulet: UIBarButtonItem!
    @IBOutlet weak var showRegisterButtonOutlet: UIButton!
    
    @IBAction func logOutAction(_ sender: Any) {
        
        if KeyChainManager.shared.get("userid") != nil {
            
            KeyChainManager.shared.delete("userid")
            UserManager.totalScore = 0
            UserManager.loginCounts = 0
            
            UserManager.fishingHighest = 0
            UserManager.jellyFishHighest = 0
            showRegisterButtonOutlet.isHidden = false
            showRegisterButtonOutlet.setTitle(
                "目前尚未登入！請先登入後體驗全部功能！", for: .normal)
            logoutOulet.isEnabled = false
            logoutOulet.tintColor = .white
            runLightViewLabel.alpha = 0
        }
    }
    
    @IBOutlet weak var runLightViewLabel: UILabel!
    
    @IBAction func goToLogin(_ sender: Any) {
        
        guard let loginViewController =
            UIStoryboard.auth.instantiateInitialViewController()
            else { return }
        
        loginViewController.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(loginViewController,
                                                 animated: true)
        
    }
    
    @IBOutlet weak var bannerCollectionView: UICollectionView! {
        didSet{
            bannerCollectionView.delegate = self
            bannerCollectionView.dataSource = self
            
        }
    }
    
    @IBOutlet weak var hotCollectionView: UICollectionView!{
        didSet{
            hotCollectionView.delegate = self
            hotCollectionView.dataSource = self
        }
    }
    func runlight() {
        
        self.runLightView.backgroundColor = .clear
        
        self.runLightViewLabel.frame.origin.x =
            UIScreen.main.bounds.width
        
        var runLightAnimation: UIViewPropertyAnimator?
        
        runLightAnimation = UIViewPropertyAnimator(
            duration: 15, curve: .linear, animations:
            {
                UIView.setAnimationRepeatCount(999);
                self.runLightViewLabel.frame.origin.x =
                    -self.runLightViewLabel.frame.width
        })
        runLightAnimation?.startAnimation()
    }
    
    func timerEnabled(){
        
        self.timer = Timer.scheduledTimer(
            timeInterval: 4, target: self,
            selector: #selector(autoScroll),
            userInfo: nil, repeats: true)
    }
    
    var x = 0
    @objc func autoScroll() {
        
        if self.x <= rankList.item.count - 1 {
            
            let indexPath = IndexPath(item: x, section: 0)
            self.bannerCollectionView.scrollToItem(
                at: indexPath,
                at: .centeredHorizontally,
                animated: true)
            
            self.x = self.x + 1
            
        } else {
            
            self.x = 0
            
            self.bannerCollectionView.scrollToItem(
                at: IndexPath(item: 0, section: 0),
                at: .centeredHorizontally,
                animated: true)
        }
    }
    
    lazy var cardLayout: FlatCardCollectionViewLayout = {
        
        let layout = FlatCardCollectionViewLayout()
        
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width * 3 / 5 ,
            height: bannerCollectionView.frame.height
        )
        
        return layout
    }()
    
    var fishRankData: [RankData] = [] {
           didSet{
               runLightViewLabel.text =
               "恭喜玩家：\(self.fishRankData.first?.name ?? "")獲得釣魚高手排行第一名"

               bannerCollectionView.reloadData()
           }
       }
       var jellyRankData: [RankData] = [] {
           didSet{
               runLightViewLabel.text =
               "恭喜玩家：\(self.jellyRankData.first?.name ?? "")獲得打水母排行第一名"
               bannerCollectionView.reloadData()
           }
       }
       
       var loginRankData: [RankData] = [] {
           didSet{
               bannerCollectionView.reloadData()
           }
       }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViewLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timerEnabled()
        
        for type in ChampionList.allCases {
            RankManager.shared.getHighestData(type: type,
                                              completion:
                {[weak self] data in
                    
                    switch type {
                    case .fishing : self?.fishRankData = data
                    case .jellyFish: self?.jellyRankData = data
                    case .login: self?.loginRankData = data
                        
                    }
            })
        }

        if KeyChainManager.shared.get("userid") != nil {
            runLightViewLabel.alpha = 1
            runlight()
            showRegisterButtonOutlet.isHidden = true
            logoutOulet.isEnabled = true
            logoutOulet.tintColor = .white
        } else {
            logoutOulet.isEnabled = false
            logoutOulet.tintColor = UIColor.poseidonBlue
            runLightViewLabel.alpha = 0
        }
        
        navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        hotCollectionView.contentInset = UIEdgeInsets(
            top: (hotCollectionView.contentSize.height) / 5 ,
            left: 0,
            bottom: 0,
            right: 0)
        
        self.bannerCollectionView.collectionViewLayout = cardLayout
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
    }
    
}

extension LobbyViewController:  UICollectionViewDelegate,
    UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath)
        -> UICollectionReusableView {
        
        if collectionView == hotCollectionView {
            
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView
                    .dequeueReusableSupplementaryView(
                        ofKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: String(
                            describing: HotCollectionHeaderView.self),
                        for: indexPath)
                
                guard let headerView = header
                    as? HotCollectionHeaderView else { return header }
                
                view.layoutIfNeeded()
                headerView.headerTitle.text = headerTitles[indexPath.row]
                return headerView
            }
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int)
        -> CGSize {
            
            if collectionView == hotCollectionView {
                return CGSize(width: UIScreen.main.bounds.width,
                              height: 40.0)
            }
            return CGSize(width: 0, height: 0)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int)
        -> Int {
            
            if collectionView == hotCollectionView {
                return hotItems.item.count
            } else {
                return rankList.item.count
            }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            
            if collectionView == hotCollectionView {
                let cell = hotCollectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing:
                        HotCollectionViewCell.self),
                    for: indexPath)
                
                guard let hotCell = cell as? HotCollectionViewCell
                    else { return cell }
                
                hotCell.homeCollectionViewImage.image =
                    hotItems.item[indexPath.row].image
                hotCell.homeCollectonViewLabel.text =
                    hotItems.item[indexPath.row].title
                hotCell.homeCollectonViewLabel.textColor =
                    hotItems.item[indexPath.row].color
                
                return hotCell
                
            } else {
                
                let cell = bannerCollectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing:
                        BannerCollectionViewCell.self),
                    for: indexPath)
                guard let bannerCell = cell as? BannerCollectionViewCell
                    
                    else { return cell }
                
                bannerCell.bannerImages.image = UIImage.asset(.champion)
                
                var championName = ""
                var championScore = ""
                
                switch indexPath.row {
                case 0:
                    championName = "暱稱：\( self.fishRankData.first?.name ?? "讀取資料中")"
                    championScore =  "最高積分：\(self.fishRankData.first?.highest ?? 0)"
                case 1:
                    championName = "暱稱：\(self.jellyRankData.first?.name ?? "讀取資料中")"
                    championScore =  "最高積分：\(self.jellyRankData.first?.highest ?? 0)"
                case 2:
                    championName = "暱稱：\(self.loginRankData.first?.name ?? "讀取資料中")"
                    championScore =  "登入天數：\(self.loginRankData.first?.highest ?? 0)"
                    
                default:
                    print("error")
                }
                bannerCell.bannerTitle.text =
                    rankList.item[indexPath.row].title
                bannerCell.iconImage.image =
                    rankList.item[indexPath.row].image
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
        
        hotCollectionView.collectionViewLayout = flowLayout
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let goStoryViewController = UIStoryboard
            .mission
            .instantiateViewController(withIdentifier:
                "StoryViewController")
            as! StoryViewController
        
        if KeyChainManager.shared.get("userid") != nil {
            
            if collectionView == hotCollectionView {
                
                switch indexPath.row {
                    
                case 0:
                    goStoryViewController.storyText =
                        StoryContent.mapStory
                    goStoryViewController.targetText =
                        StoryContent.mapTarget
                    self.navigationController?.pushViewController(
                        goStoryViewController, animated: true)
                case 1:
                    
                    goStoryViewController.storyText =
                        StoryContent.fishingStory
                    goStoryViewController.targetText =
                        StoryContent.fishingTarget
                    self.navigationController?.pushViewController(
                        goStoryViewController, animated: true)
                case 2:
                    goStoryViewController.storyText =
                        StoryContent.jellyFishStory
                    goStoryViewController.targetText =
                        StoryContent.jellyFishTarget
                    self.navigationController?.pushViewController(
                        goStoryViewController, animated: true)
                case 3:
                    
                    let loginTodayController = UIStoryboard
                        .mission
                        .instantiateViewController(withIdentifier:
                            "LoginTodayViewController")
                        as! LoginTodayViewController
                    loginTodayController.modalPresentationStyle =
                        .overFullScreen
                    loginTodayController.modalTransitionStyle =
                        .crossDissolve
                    
                    present(loginTodayController,
                            animated: true,
                            completion: nil)
                    
                    
                case 4:
                    ShareManager.checkIsShareToday(sender: self)
                    
                default:
                    print("no view")
                }
            }
            
        }else {
            guard let loginViewController =
                UIStoryboard.auth.instantiateInitialViewController()
                else { return }
            
            loginViewController.modalPresentationStyle =
                .overFullScreen
            navigationController?.pushViewController(
                loginViewController, animated: true)
        }
    }
}
