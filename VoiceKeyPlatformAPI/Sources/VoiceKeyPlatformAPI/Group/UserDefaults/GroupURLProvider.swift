//
//  GroupURLProvider.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 19.01.2021.
//

import Foundation

@objc class GroupURLProvider: UserDefaultsHelper {
    
    override var key: String?{
        get {
            return "kGroupURLIdentifier"
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
