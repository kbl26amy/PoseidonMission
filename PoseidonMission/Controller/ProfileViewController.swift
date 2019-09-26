//
//  ProfileViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
//import CoreImage

class ProfileViewController: PMBaseViewController  {
    var photoArray:[String] = []
    var userData: UserData? {
        didSet{
            userName.text = userData?.userName
            userEmail.text = userData?.email
            userTotalPoint.text = "暢遊卷： \( userData?.totalScore ?? 0)張"
        }
    }
    
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBAction func segmentedControll(_ sender: Any) {
        if (sender as AnyObject).selectedSegmentIndex == 0 {
            self.getPointTableView.isHidden = false
                   self.hintLabel.alpha = 0
               } else {
            self.getPointTableView.isHidden = true
            self.hintLabel.alpha = 1
               }
    }
    @IBAction func editPhoto(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        
        // 委任代理
        imagePickerController.delegate = self
        
        // 建立一個 UIAlertController 的實體
        // 設定 UIAlertController 的標題與樣式為 動作清單 (actionSheet)
        let imagePickerAlertController = UIAlertController(title: "上傳圖片", message: "請選擇要上傳的圖片", preferredStyle: .actionSheet)
        
        // 建立三個 UIAlertAction 的實體
        // 新增 UIAlertAction 在 UIAlertController actionSheet 的 動作 (action) 與標題
        let imageFromLibAction = UIAlertAction(title: "照片圖庫", style: .default) { (Void) in
            
            // 判斷是否可以從照片圖庫取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.photoLibrary)，並 present UIImagePickerController
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        let imageFromCameraAction = UIAlertAction(title: "相機", style: .default) { (Void) in
            
            // 判斷是否可以從相機取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.camera)，並 present UIImagePickerController
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        
        // 新增一個取消動作，讓使用者可以跳出 UIAlertController
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (Void) in
            
            imagePickerAlertController.dismiss(animated: true, completion: nil)
        }
        
        // 將上面三個 UIAlertAction 動作加入 UIAlertController
        imagePickerAlertController.addAction(imageFromLibAction)
        imagePickerAlertController.addAction(imageFromCameraAction)
        imagePickerAlertController.addAction(cancelAction)
        
        // 當使用者按下 uploadBtnAction 時會 present 剛剛建立好的三個 UIAlertAction 動作與
        present(imagePickerAlertController, animated: true, completion: nil)
    
    }
    var userRecordData: [UserRecord]?{
        didSet{
            getPointTableView.reloadData()
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
        
        
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadFile()
        if photoArray != []{
            let fileManager = FileManager.default
            let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            let docUrl = docUrls.last
            let url =  docUrl?.appendingPathComponent("\(KeyChainManager.shared.get("userid")!).txt")
            userImage.image = UIImage(contentsOfFile: url!.path)
        }
        UserManager.shared.getUserData(completion:  { user in
            self.userData = user
        })
        
        UserManager.shared.getUserRecord(completion: { records in
            
            self.userRecordData = records
        })
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userRecordData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getPointTableView.dequeueReusableCell(
            withIdentifier: String(describing: GetPointTableViewCell.self),
            for: indexPath)
        
        guard let getPointCell = cell as? GetPointTableViewCell else { return cell }
        
        getPointCell.getPointCount.text = "+ \(userRecordData?[indexPath.row].score ?? 0)"
        getPointCell.GetPointTime.text = userRecordData?[indexPath.row].time
        getPointCell.getPointImage.image = UIImage(named: userRecordData?[indexPath.row].source.rawValue ?? "map")
        
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
        return getPointCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
   
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 取得從 UIImagePickerController 選擇的檔案
            
            guard let pickedImage = info[.originalImage] as? UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
            
            selectedImageFromPicker = pickedImage
        
        // 當判斷有 selectedImage 時，我們會在 if 判斷式裡將圖片上傳
        if let selectedImage = selectedImageFromPicker {
            
            self.userImage.image = selectedImage
            //取得路徑
            let fileManager = FileManager.default
            let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            let docUrl = docUrls.first
            let name = "\(KeyChainManager.shared.get("userid")!).jpg"
            let url = docUrl?.appendingPathComponent(name)
            let data = pickedImage.jpegData(compressionQuality:0.9)
            try! data?.write(to: url!)
            photoArray.append(name)
//            saveFile()
          
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //讀取紀錄位址的photoArray
    func loadFile(){
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in:
            .userDomainMask)
        let docUrl = docUrls.last
        let url = docUrl?.appendingPathComponent("\(KeyChainManager.shared.get("userid")!).txt")
        if let array = NSArray(contentsOf: url!){
            photoArray = array as! [String]
        }}
}

