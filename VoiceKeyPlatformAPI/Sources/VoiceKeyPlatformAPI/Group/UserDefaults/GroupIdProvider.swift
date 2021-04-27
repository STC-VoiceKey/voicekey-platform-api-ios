//
//  GroupIdProvider.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 26.01.2021.
//

import Foundation

@objc class GroupIdProvider: UserDefaultsHelper {
    
    override var key: String?{
        get {
            return "kGroupIdIdentifier"
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
