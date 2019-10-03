//
//  KeyChainManager.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/23.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import KeychainSwift

class KeyChainManager {

    static let shared = KeyChainManager()
        
    private let keychain = KeychainSwift()
    
    func get(_ text: String) -> String? {
        
        return KeyChainManager.shared.keychain.get(text)
    }
    
    func set(_ text: String, forKey key: String) {
        
        KeyChainManager.shared.keychain
            .set(text,forKey: key)
        
    }
    
    func delete(_ text: String) {
        
        KeyChainManager.shared.keychain.delete(text)
        
    }
}
