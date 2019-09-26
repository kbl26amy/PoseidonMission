//
//  MissionContent.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/10.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation

struct MissionContent {
    
    static let missionTitles:[missionTitles] = [.map, .jellyFish, .fishing, .login, .invite]
    
    static let missionPictures:[missionPics] = [.mapPic, .jellyFishPic, .fishingPic, .loginPic, .invitePic]
    
    static let missionIntroduction = [MissionContent.mapMissionText,MissionContent.jellyFishMissionText,MissionContent.fishingMissionText,MissionContent.shareMissionText,MissionContent.loginTodayMissionText]

    static let mapMissionText = "藏寶圖探索進度100%以後，會出現藏寶地點。"
    static let jellyFishMissionText = "找出表情邪惡的紅色水母，每1000積分可獲得1張暢遊卷！"
    static let fishingMissionText = "能量條滿時下勾釣起魚，每300積分可獲得1張暢遊卷！"
    static let loginTodayMissionText = "每天簽到可獲得2張暢遊卷，連續簽到有更多額外張數。"
    static let shareMissionText = "分享APP即可獲得2張暢遊卷。"
    
    static let missionReward = [ 2, 4, 5, 2, 2 ]
    
}

enum missionPics: String {
    case fishingPic = "fishingPic"
    case loginPic = "loginPic"
    case jellyFishPic = "jellyFishPic"
    case invitePic = "invitePic"
    case mapPic = "mapPic"
}

enum missionTitles: String {
    case fishing = "釣魚"
    case login = "簽到"
    case jellyFish = "打水母"
    case invite = "邀請好友"
    case map = "藏寶圖"
}
