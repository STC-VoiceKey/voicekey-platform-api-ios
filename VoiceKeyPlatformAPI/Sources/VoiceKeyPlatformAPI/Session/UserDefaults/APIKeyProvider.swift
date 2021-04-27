//
//  APIKeyManager.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 01.12.2020.
//

import Foundation

@objc class APIKeyProvider: UserDefaultsHelper {
    
    override var key: String?{
        get {
            return "kAPIKeyIdentifier"
        }
    }
    
    override var value: Any? {
        get {
            guard super.value != nil else {
                return Bundle.main.object(forInfoDictionaryKey: self.key!)
            }
            return super.value
        }
    }
}
