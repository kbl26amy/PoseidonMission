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
    
    @IBOutlet weak var logoutOulet: UIBarButtonItem!
    @IBOutlet weak var showRegisterButtonOutlet: UIButton!
    @IBAction func logOutAction(_ sender: Any) {
        print("logout")
       
            if Auth.auth().currentUser != nil {
                do {
                    try Auth.auth().signOut()
                    showRegisterButtonOutlet.isHidden = false
                    logoutOulet.isEnabled = false
                    logoutOulet.tintColor = .lightGray
                    runLightViewLabel.alpha = 0
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
    }
 
    
    @IBOutlet weak var runLightViewLabel: UILabel!
    
    func runlight () {
        
        var frame = runLightViewLabel.frame
        frame.origin.x = UIScreen.main.bounds.width
        runLightViewLabel.frame = frame
        UIView.beginAnimations("testAnimation", context: nil)
        UIView.setAnimationDuration(8.8)
        UIView.setAnimationCurve(.linear)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationRepeatAutoreverses(false)
        UIView.setAnimationRepeatCount(999999)
        frame = runLightViewLabel.frame
        frame.origin.x = -UIScreen.main.bounds.width
        runLightViewLabel.frame = frame
        UIView.commitAnimations()
    
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        
        guard let loginViewController = UIStoryboard.auth.instantiateInitialViewController() else { return }
        
        loginViewController.modalPresentationStyle = .overFullScreen
        
        navigationController?.pushViewController(loginViewController, animated: true)

        
    }
    
    lazy var cardLayout: FlatCardCollectionViewLayout = {
        let layout = FlatCardCollectionViewLayout()
        layout.itemSize = CGSize(width: bannerCollectionView.contentSize.width, height: bannerCollectionView.contentSize.height)
        return layout
    }()
    
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
    
    var bannerImages = ["FishingRank", "JellyRank", "LoginRank" ]
    
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
        runlight ()
      
//        self.bannerCollectionView.showsVerticalScrollIndicator = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.isNavigationBarHidden = false
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
       
        homeCollectionView.contentInset = UIEdgeInsets(top: (homeCollectionView.contentSize.height) / 5 , left: 0, bottom: 0, right: 0)
        self.bannerCollectionView.collectionViewLayout = cardLayout
 
        if Auth.auth().currentUser != nil {
            runLightViewLabel.alpha = 1
            runlight ()
            showRegisterButtonOutlet.isHidden = true
            logoutOulet.isEnabled = true
            logoutOulet.tintColor = UIColor(red: 131.0/255.0, green: 211.0/255.0, blue: 222.0/255.0, alpha: 1.0)
        } else {
            logoutOulet.isEnabled = false
            logoutOulet.tintColor = .lightGray
            runLightViewLabel.alpha = 0
        }
    }

}

extension LobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == homeCollectionView {
            return homeCollectionLabel.count
        } else {
            return bannerImages.count
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
            
            bannerCell.layer.cornerRadius = 6.0
            bannerCell.layer.borderWidth = 1.0
            bannerCell.layer.borderColor = UIColor.clear.cgColor
            bannerCell.layer.shadowColor = UIColor.gray.cgColor
            bannerCell.layer.shadowOffset = CGSize(width: 0, height: 3)
            bannerCell.layer.shadowRadius = 6.0
            
            bannerCell.bannerImages.image = UIImage(named: bannerImages[indexPath.row])
            
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
    
    func shareClickButton(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "點擊分享", message: "分享 APP 給你的好友", preferredStyle: UIAlertController.Style.actionSheet)
        
        let facebookPostAction = UIAlertAction(title: "分享", style: UIAlertAction.Style.default) { (action) -> Void in
            
            let shareMessage = URL(string: "https://trello.com/b/O8akxJeO/波賽頓出任務")
            let shareViewController = UIActivityViewController(activityItems: [shareMessage as Any], applicationActivities: nil)
            
            shareViewController.excludedActivityTypes = [UIActivity.ActivityType.mail,UIActivity.ActivityType.airDrop,UIActivity.ActivityType.message]
            
            self.present(shareViewController, animated: true, completion: nil)
            
        }
        
        let dismissAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel) { (action) -> Void in
            
        }
        
        actionSheet.addAction(facebookPostAction)
        actionSheet.addAction(dismissAction)
        
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let goStoryViewController = UIStoryboard.mission.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController
        
        if Auth.auth().currentUser != nil {
            
        if collectionView == homeCollectionView {

        switch indexPath.row {
            
        case 0:
            let loginTodayController = UIStoryboard.mission.instantiateViewController(withIdentifier: "LoginTodayViewController") as! LoginTodayViewController 
            loginTodayController.modalPresentationStyle = .overCurrentContext
            loginTodayController.modalTransitionStyle = .crossDissolve
            present(loginTodayController, animated: true, completion: nil)
            
        case 1:
            
            shareClickButton(self)
        case 2:
            goStoryViewController.storyText = StoryContent.mapStory
            goStoryViewController.targetText = StoryContent.mapTarget
          
            self.navigationController?.pushViewController(goStoryViewController, animated: true)
            
        case 3:
            goStoryViewController.storyText = StoryContent.fishingStory
            goStoryViewController.targetText = StoryContent.fishingTarget
            
            self.navigationController?.pushViewController(goStoryViewController, animated: true)
            
        case 4:
            goStoryViewController.storyText = StoryContent.jellyFishStory
            goStoryViewController.targetText = StoryContent.jellyFishTarget
        
            self.navigationController?.pushViewController(goStoryViewController, animated: true)
            
        default:
            print("no view")
            
            }
            }
            
        }else {
            guard let loginViewController = UIStoryboard.auth.instantiateInitialViewController() else { return }
            
            loginViewController.modalPresentationStyle = .overFullScreen
            
            navigationController?.pushViewController(loginViewController, animated: true)
        }
}
}
