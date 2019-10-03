//
//  ProfileViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import Kingfisher
import NVActivityIndicatorView

class ProfileViewController: PMBaseViewController  {
    
    @IBOutlet weak var giftCount: UILabel!
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    
    var userData: UserData? {
        didSet{
            userName.text = userData?.userName
            userEmail.text = userData?.email
            giftCount.text = "\(userData?.getGift ?? 0)"
            userTotalPoint.text = "暢遊卷： \( userData?.totalScore ?? 0)張"
            if userData?.photo != nil {
                
                let url = URL(string: (userData?.photo)!)
                userImage.kf.setImage(with: url)
            } else {
                userImage.image = UIImage(named: "ship")
            }
        }
    }
    
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        print(segmentedController.selectedSegmentIndex)
        getPointTableView.delegate = self
        getPointTableView.dataSource = self
        getPointTableView.reloadData()
        segmentedControll()
    }
    
    func segmentedControll() {
        if segmentedController.selectedSegmentIndex == 0 {
            
            if userRecordData?.count == 0 || userRecordData == nil {
                self.getPointTableView.isHidden = true
                self.hintLabel.alpha = 1
                self.hintLabel.text = "目前無獲得積分紀錄"
            } else {
                self.getPointTableView.isHidden = false
                self.hintLabel.alpha = 0
            }
        } else {
            if exchangeRecordData?.count == 0 || exchangeRecordData == nil {
                self.getPointTableView.isHidden = true
                self.hintLabel.text = "目前無兌換紀錄"
                self.hintLabel.alpha = 1
            } else {
                self.getPointTableView.isHidden = false
                self.hintLabel.alpha = 0
            }
        }
    }
    
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBAction func editPhoto(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let imagePickerAlertController = UIAlertController(title: "上傳圖片",
                                                           message: "請選擇要上傳的圖片",
                                                           preferredStyle: .actionSheet)
        
        let imageFromLibAction = UIAlertAction(title: "照片圖庫",
                                               style: .default)
        { (Void) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true,
                             completion: nil)
            }
        }
        let imageFromCameraAction = UIAlertAction(title: "相機",
                                                  style: .default)
        { (Void) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true,
                             completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "取消",
                                         style: .cancel)
        { (Void) in
            
            imagePickerAlertController.dismiss(animated: true,
                                               completion: nil)
        }
        imagePickerAlertController.addAction(imageFromLibAction)
        imagePickerAlertController.addAction(imageFromCameraAction)
        imagePickerAlertController.addAction(cancelAction)
        present(imagePickerAlertController, animated: true,
                completion: nil)
        
    }
    var userRecordData: [UserRecord]?{
        didSet{
            getPointTableView.reloadData()
            loadingView.stopAnimating()
//            segmentedController.isHighlighted = true
//            segmentedController.selectedSegmentIndex = 0
        }
    }
    
    var exchangeRecordData: [ExchangeRecord]?{
        didSet{
            getPointTableView.reloadData()
            loadingView.stopAnimating()
        }
    }
    
    static var totalScore: Int = 0
    static var jellyFishHighest: Int = 0
    static var fishingHighest: Int = 0
    static var loginCounts: Int = 0
    
    var selectedImageFromPicker: UIImage?
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userTotalPoint: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var getPointTableView: UITableView!{
        didSet{
            getPointTableView.delegate = self
            getPointTableView.dataSource = self
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.layer.cornerRadius = userImage.frame.width / 2
        loadingView.startAnimating()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserManager.shared.getUserData(completion:  { user in
            self.userData = user
        })
        
        UserManager.shared.getUserRecord(completion: { records in
            
            self.userRecordData = records
            self.segmentedControll()
        })
        
        UserManager.shared.getExchangeRecord(completion: { records in
            
            self.exchangeRecordData = records
            self.segmentedControll()
        })
        
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        switch self.segmentedController.selectedSegmentIndex {
        case 0: return userRecordData?.count ?? 0
        default:
            return exchangeRecordData?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = getPointTableView.dequeueReusableCell(
            withIdentifier: String(describing: GetPointTableViewCell.self),
            for: indexPath)
        
        guard let getPointCell = cell as? GetPointTableViewCell
            else { return cell }
        
        switch self.segmentedController.selectedSegmentIndex {
        case 0:
            
            getPointCell.getPointCount.text =
            "+ \(userRecordData?[indexPath.row].score ?? 0)"
            
            getPointCell.GetPointTime.text =
                userRecordData?[indexPath.row].time
            
            getPointCell.getPointImage.image = UIImage(named:
                userRecordData?[indexPath.row]
                    .source
                    .rawValue ?? "map")
            
            
            var source: String?
            
            
            switch userRecordData?[indexPath.row].source {
            case .map: source = "藏寶圖"
            case .jellyFish: source = "打水母"
            case .fishing: source = "釣魚"
            case .loginToday: source = "簽到"
            case .share: source = "邀請好友"
            case .none: source = ""
                
            }
            
            getPointCell.getPointLabel.text = source
            
        default:
            getPointCell.getPointCount.text = ""
            getPointCell.getPointLabel.text =
                exchangeRecordData?[indexPath.row].source
            getPointCell.GetPointTime.text = exchangeRecordData?[indexPath.row].introduction
            
            var image: UIImage?
            
            switch exchangeRecordData?[indexPath.row].source {
            case Rewards.pearl.title: image = Rewards.pearl.image
            case Rewards.coupon.title: image = Rewards.coupon.image
            case .none: image = Rewards.pearl.image
            case .some(_): image = Rewards.pearl.image
                
            }
            getPointCell.getPointImage.image = image
        }
        return getPointCell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage]
            as? UIImage else {fatalError(
                "Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        selectedImageFromPicker = pickedImage
        if let selectedImage = selectedImageFromPicker {
            let storageRef = Storage
                .storage()
                .reference()
                .child("AppCodaFireUpload")
                .child("\(KeyChainManager.shared.get("userid")!).png")
            
            self.userImage.image = selectedImage
            
            if let uploadData = selectedImage.pngData() {
                
                storageRef.putData(uploadData, metadata: nil) {
                    (data, error) in
                    if let error = error {
                        debugPrint(error.localizedDescription)
                        return
                    }
                    
                    let uniqueString = NSUUID().uuidString
                    storageRef.downloadURL(completion:{ (url, error) in
                        guard let downloadURL = url else {
                            return
                        }
                        print(downloadURL.absoluteString)
                        
                        let photoUrl = ["photo": "\(downloadURL)"]
                        FireBaseHelper.updateData(update: photoUrl)
                        
                        let databaseRef = Database
                            .database()
                            .reference(withPath: "ID/\(uniqueString)/Profile/Photo")
                        
                        databaseRef.setValue(downloadURL.absoluteString,
                                             withCompletionBlock: { (error, dataRef) in
                                                
                                                if error != nil {
                                                    print("Database Error: \(error!.localizedDescription)")
                                                } else {
                                                    print("圖片已儲存")}
                                                
                        })
                    })
                }
            }
            
            dismiss(animated: true, completion: nil)
        }
    }
    
}

