//
//  SessionResultAdapter.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 10.12.2020.
//

import Foundation

protocol SessionResultAdapter{
    init(_ result:Dictionary<String, Any>)
    var sessionId:String? { get }
}

class SessionResultAdapterImplementation: SessionResultAdapter {
    var sessionResult:Dictionary<String, Any>
    
    required init(_ result: Dictionary<String, Any>) {
        sessionResult = result
    }
    
    var sessionId: String? {
        get {
            let value = sessionResult["session_id"] as? String
            return value
        }
    }
    
}
