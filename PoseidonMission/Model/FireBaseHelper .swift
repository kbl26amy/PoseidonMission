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
    static func getUserData(completion: @escaping (DocumentSnapshot?) -> Void ) {
        
        let db = Firestore.firestore()
     
        db
        .collection("user")
        .document(Auth.auth().currentUser!.uid)
        .getDocument { (document, error) in
            
            completion(document)
 
        }
    }
    
    
    // 添加積分獲得紀錄
    func addUserDoc(){
        let db = Firestore.firestore()
        
            db
            .collection("user")
            .document(Auth.auth().currentUser!.uid)
            .collection("records")
            .document()
            .setData([:]){ (error) in
                
        if let error = error {
            print(error)}
        
        }
        
    }
    //update用戶資料
    func upDateData(){
        let db = Firestore.firestore()
        db
        .collection("user")
        .whereField("email", isEqualTo: Auth.auth().currentUser!.email ?? "no email")
        .getDocuments { (querySnapshot, error) in
                
        if let querySnapshot = querySnapshot {
                
            let document = querySnapshot.documents.first
                
            document?.reference.updateData([:], completion: { (error) in
            
        })
        
        }
        
        }
        
    }
}

