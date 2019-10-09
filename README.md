# PoseidonMission
製作期間大量使用 UIViewPropertyAnimator 動畫，其中以釣魚頁面處理最多動畫間的問題，運用物件導向中多型與封裝的概念，將魚製作成物件，並進行相關動畫演示：

1. 設計protocol

```
protocol FishGenerator {
    
    func fetchFishImageView() -> UIImageView
}
```
2. 運用 extension 讓9種魚的圖片隨機產生
```
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
```
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

![image](https://github.com/kbl26amy/PoseidonMission/blob/master/app%20introduction.png?raw=true)


