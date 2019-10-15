# PoseidonMission
波賽頓出任務為一個任務型 APP，製作期間大量使用 UIViewPropertyAnimator 動畫，用戶可以選擇喜愛的任務，前往執行並獲得暢遊卷，再消耗暢遊卷抽寶箱獲得海底寶藏。

![image](https://github.com/kbl26amy/PoseidonMission/blob/master/fishing.gif?raw=true)
![image](https://github.com/kbl26amy/PoseidonMission/blob/master/map.gif?raw=true)
![image](https://github.com/kbl26amy/PoseidonMission/blob/master/jellyFish.gif?raw=true)


>*支援系統：* 
     
*  首頁：使用 `collectionview`製作輪播banner效果，並且計算中心位置做放大縮小，再針對排行榜第一名進行跑馬燈展示
     
*  排行：在 `tableView` 中加入 `collectionview` 製作橫向滑動，並且可以贈送禮物給排行榜上的用戶 
     
*  個人：可以看到所有兌換與遊戲積分紀錄，並且上傳個人照片，該照片將會展示在排行榜上面
     
![image](https://github.com/kbl26amy/PoseidonMission/blob/master/LobbyView.gif?raw=true)
![image](https://github.com/kbl26amy/PoseidonMission/blob/master/profile.gif?raw=true)
![image](https://github.com/kbl26amy/PoseidonMission/blob/master/rankView.gif?raw=true)

>特色說明：

### *一、動畫與遊戲製作內容：*
   
其中以釣魚頁面處理最多動畫間的問題，運用物件導向中多型與封裝的概念，將魚製作成物件，並進行相關動畫演示：

1. 設計protocol

```Swift
protocol FishGenerator {
    
    func fetchFishImageView() -> UIImageView
}
```
2. 運用 extension 讓9種魚的圖片隨機產生
```Swift 
extension FishGenerator {
    
    func randomFishImage() -> UIImageView? {
        
        let fishs = [UIImage.asset(.blueFish),
                     UIImage.asset(.redThornFish),
                     UIImage.asset(.purpleFish),
                     UIImage.asset(.greenFish),
                     UIImage.asset(.longFish),
                     UIImage.asset(.lightBlueFish),
                     UIImage.asset(.darkRedFish),
                     UIImage.asset(.LanternFish),
                     UIImage.asset(.shark)]
        
        let fishImageView = UIImageView(image: fishs.randomElement()!)
        
        return fishImageView
    }
}
```

3. 設計多種魚的路線，遵從我們設計的 protocol，之後將每個路線存成同一個array，藉此取得一個個可以游動的魚
```Swift
struct PathOne: FishGenerator {
    
    func fetchFishImageView() -> UIImageView {
        let fish = randomFishImage()
        fish?.frame = CGRect(x: -60, y: 300, width: 40, height: 30)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 11, delay: 0, animations: {
            fish?.frame.origin.x = UIScreen.main.bounds.size.width
         
            fish?.frame.origin.y = UIScreen.main.bounds.size.height / 2
            
        }, completion: nil)
     
        return fish!
    }
}
```
### *二、資料處理與網路相關：*
    
除了動畫設計之外，也使用Firebase的各種資料處理方法，完成每日次數限制、用戶總成績、兌換資料與排行榜資料顯示，其中在處理 Firebase 回傳的資料時，透過兩次Closure 方法，額外製作一個 User Manager 處理資料的型別，完成資料的同步：

```Swift
 func getUserRecord(completion: @escaping ([UserRecord]?) -> Void) {
        
        FireBaseHelper.getUserRecord(completion: { querySnapshot in
            
            guard let docs = querySnapshot?.documents else {
                    
                    print("error")
                    
                    completion(nil)
                    
                    return
            }
            
            self.userRecord = []
            
            // 0..< docs.count
            for index in docs.indices {
              
                let score = docs[index].data()["score"] as! Int
                let source = docs[index].data()["source"] as! String
                let time = docs[index].data()["time"] as! Timestamp
                let playTime = DateManager.timeStampToString(date: time, text: "yyyy-MM-dd HH:mm:ss")
        
                self.userRecord.append(UserRecord(time: playTime,
                                                  source: RecordSource(rawValue: source) ?? .loginToday,
                                                  score: score))
            }
            
            completion(self.userRecord)
            
        })
    }
```

#### *三、Swift 開發技巧相關：*
    
另外在排行榜頁面，是在 TableView 的 cell 中使用 CollectionView ，並且完成兩個 section 中 cell 的資料傳遞與功能實現，因此大量使用 Closure 的方式：

```Swift
    var giftClosure: ((ContentCollectionViewCell, [String], String) -> ())?
```
在 closure 中修改按鈕的變化，並且留意 retain cycle 的問題，將所有贈送過禮物的用戶 Id 記錄到 Firebase 上，並且解決頁面滑動時cell reuse 可能產生的問題
 
```Swift
  rankCell.giftClosure = { cell, giftId, singleId in
                
            if rankCell.giveId.contains(
                 self.fishRankData[indexPath.row].userId) {
                        cell.giftButton.isEnabled = false
                        cell.giftButton.setBackgroundImage(UIImage(systemName: "gift.fill"), for: .normal)
                        cell.giftButton.tintColor = UIColor.darkBlue
                            } else {
                              cell.giftButton.isEnabled = true
                              cell.giftButton.setBackgroundImage(UIImage(systemName: "gift"), for: .normal)
                              cell.giftButton.tintColor = UIColor.darkGray
                              }
                } 
            
                let fishGiveIdData = ["fishGiveId": self.fishGiveId]
                FireBaseHelper.updateData(update: fishGiveIdData)
                FireBaseHelper.updateOtherData(other: singleId)
                
            }
```

### Third-Party Libraries
* Firebase
     Auth - 驗證用戶註冊與登入資訊，並針對錯誤進行處理
     Storage - 儲存用戶上傳後的照片，並顯示於畫面
     Crashlytics - 掌握 App 的 Crash報告
* Kingfisher - 善用快取的方式處理網路圖片並呈現在 App
* IQKeyboardManager - 解決鍵盤彈起時遮住輸入框的工具
* AV - 顯示狀態的提示窗
     
### Requirements
-----------------
* Xcode11
* iOS 13

### download (ios13 Device only)
-------------------
https://apps.apple.com/tw/app/波賽頓出任務/id1481162004

截圖展示：
![image](https://github.com/kbl26amy/PoseidonMission/blob/master/app%20introduction.png?raw=true)


