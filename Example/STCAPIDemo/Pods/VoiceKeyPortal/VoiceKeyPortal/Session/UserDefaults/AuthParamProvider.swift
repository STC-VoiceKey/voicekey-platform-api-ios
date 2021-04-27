//
//  AuthParamManager.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 01.12.2020.
//

import Foundation

@objc class AuthParamProvider: UserDefaultsHelper {
    
    override var key: String?{
        get {
            return "kAuthSessionIdentifier"
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
