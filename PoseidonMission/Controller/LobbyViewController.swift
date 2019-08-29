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
      
        self.bannerCollectionView.showsVerticalScrollIndicator = false
        
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
            
            bannerCell.layer.cornerRadius = 6.0
            bannerCell.layer.borderWidth = 1.0
            bannerCell.layer.borderColor = UIColor.clear.cgColor
            bannerCell.layer.shadowColor = UIColor.gray.cgColor
            bannerCell.layer.shadowOffset = CGSize(width: 0, height: 3)
            bannerCell.layer.shadowRadius = 6.0
            
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
