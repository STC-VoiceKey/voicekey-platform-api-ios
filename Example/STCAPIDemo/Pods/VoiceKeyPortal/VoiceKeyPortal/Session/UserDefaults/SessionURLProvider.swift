//
//  SessionURLManager.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 01.12.2020.
//

import Foundation

@objc class SessionURLProvider: UserDefaultsHelper {
    
    override var key: String?{
        get {
            return "kSessionURLIdentifier"
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
