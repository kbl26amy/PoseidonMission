//
//  Database.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/8.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import Firebase

class FireBaseHelper {

    //獲取用戶資料
    static func getUserData(completion:
        @escaping (DocumentSnapshot?)
        -> Void ) {
        
        let db = Firestore.firestore()
     
        db
        .collection("user")
        .document(KeyChainManager.shared.get("userid")!)
        .getDocument { (document, error) in
            
            completion(document)
 
        }
    }
    
    //獲取用戶積分紀錄
    static func getUserRecord(completion:
        @escaping (QuerySnapshot?)
        -> Void ) {
        
        let db = Firestore.firestore()
        
        db
            .collection("user")
            .document(KeyChainManager.shared.get("userid")!)
            .collection("records")
            .order(by: "time", descending: true)
            .getDocuments { (querySnapshot, error) in
                
                completion(querySnapshot)
                
        }
    }
    static func getExchangeRecord(completion:
        @escaping (QuerySnapshot?)
        -> Void ) {
        
        let db = Firestore.firestore()
        
        db
            .collection("user")
            .document(KeyChainManager.shared.get("userid")!)
            .collection("exchanges")
            .order(by: "time", descending: true)
            .getDocuments { (querySnapshot, error) in
                
                completion(querySnapshot)
                
        }
    }
 
    static func getHighestData(queryParameter: String,
        completion:
        @escaping (QuerySnapshot?) -> Void ) {
        
        let db = Firestore.firestore()
        
        db
            .collection("user")
            .order(by: queryParameter, descending: true)
            .getDocuments { (document, error) in
                
                completion(document)
                
        }
    }

    // 添加積分獲得紀錄
    static func saveUserRecord(saveData:[String: Any]) {
        
        let db = Firestore.firestore()
            db
            .collection("user")
            .document(KeyChainManager.shared.get("userid")!)
            .collection("records")
            .document()
            .setData(saveData){ (error) in
                if let error = error {
                    print(error)
                }
        }
    }
    
    // 添加兌換紀錄
     static func saveExchangeRecord(saveData:[String: Any]) {
         
         let db = Firestore.firestore()
             db
             .collection("user")
             .document(KeyChainManager.shared.get("userid")!)
             .collection("exchanges")
             .document()
             .setData(saveData){ (error) in
                 if let error = error {
                     print(error)
                 }
         }
     }
    
    //update用戶資料
    static func updateData(update: [String:Any]) {
        let db = Firestore.firestore()
            
            db
            .collection("user")
            .document(KeyChainManager.shared.get("userid")!)
            .getDocument { (document, error) in
                
                document?.reference.updateData(update,
                                               completion: { (error) in
                    
                })
        }
    }
    
    static func updateOtherData(other: String) {
        var getGiftNumber = 0
        let db = Firestore.firestore()
        
        db
            .collection("user")
            .document(other)
            .getDocument { (document, error) in
                
                if document?.data()?["getGift"]  != nil {
                    getGiftNumber = document?.data()?["getGift"] as! Int
                } 
                let updateGetGift = ["getGift": getGiftNumber + 1]
                document?.reference.updateData(updateGetGift,
                                               completion: { (error) in
                                                
                })
        }
    }
    
    static func saveData(saveData: [String:Any]) {
        let db = Firestore.firestore()
        
        db
            .collection("user")
            .document(KeyChainManager.shared.get("userid")!)
            .setData(saveData,merge: true,
                     completion: { (error) in
                        if let error = error {
                            print(error)
                        }
            })
    }
}

      
