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

    static func getUserData() -> DocumentSnapshot? {
        let db = Firestore.firestore()
        var doc: DocumentSnapshot?
        db.collection("user").document(Auth.auth().currentUser!.uid).getDocument { (document, error) in
            
            if let  doc = document,  doc.exists {
                print(doc.documentID, doc.data() as Any)
                
            }else {
                doc = nil
            }
    }
        return doc
    }
    
    
    
    func addUserDoc(){
        let db = Firestore.firestore()
        db.collection("user").document(Auth.auth().currentUser!.uid).collection("records").document().setData([:]){ (error) in
        if let error = error {
            print(error)
            
        }
        
        }
        
    }
    //update用戶總積分
    
    func upDateData(){
        let db = Firestore.firestore()
       db.collection("user").whereField("email", isEqualTo: Auth.auth().currentUser!.email ?? "no email").getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                let document = querySnapshot.documents.first
                document?.reference.updateData([:], completion: { (error) in
            
        })
        
        }
        
        }
        
    }
}

