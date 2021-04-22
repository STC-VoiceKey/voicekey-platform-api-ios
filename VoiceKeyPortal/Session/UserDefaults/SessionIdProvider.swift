//
//  SessionIdProvider.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 03.12.2020.
//

import Foundation

@objc class SessionIdProvider: UserDefaultsHelper {
    override var key: String?{
        get {
            return "kSessionIdIdentifier"
        }
    }
}
