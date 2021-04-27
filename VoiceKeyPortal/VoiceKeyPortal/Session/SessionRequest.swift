//
//  SessionRequest.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 01.12.2020.
//

import Foundation

enum SessionRequest:String {
    case Domains
    case Privileges
    case LogOut
    case Check
    case LogIn
    case LogInWithKey
    
    var sessionId:String {
        let sessionProvider = SessionIdProvider()
        assert(sessionProvider.value != nil)
        return sessionProvider.stringValue!
    }
    
    var sessionUrl:String {
        let sessionURLManager = SessionURLProvider()
        let string = sessionURLManager.value as! String
        return string
    }
    
    var authParameters:Dictionary<String, Any> {
        let authParams = AuthParamProvider()
        return authParams.value as! Dictionary<String, Any>
    }
    
    var apiKey:String {
        let apiKeyDefaults = APIKeyProvider()
        return apiKeyDefaults.value as! String
    }

    var url:URL {
        return URL.init(string: urlString)!
    }
    
    private var urlString:String {
        return sessionUrl + shortUrlString
    }
    
    var shortUrlString:String {
        switch self {
        case .LogOut, .Check, .LogIn:
            return  "/session"
        case .Domains:
            return "/domains"
        case .Privileges:
            return  "/privileges"
        case .LogInWithKey:
            return "/session/key"
        }
    }
    
    var  httpMethod:String {
        switch self {
        case .Domains, .Check:
            return "GET"
        case .Privileges, .LogIn, .LogInWithKey:
            return "POST"
        case .LogOut:
            return "DELETE"
        }
    }
    
    var request:URLRequest {
        var req = URLRequest.init(url: url)
        req.httpMethod = httpMethod
        req.addValue("application/json", forHTTPHeaderField:"Content-Type")

        if self != .LogIn && self != .LogInWithKey {
            req.addValue(sessionId,     forHTTPHeaderField:"X-Session-ID")
        } 
        
        if body != nil {
            req.httpBody = body
        }
        
        return req
    }
    
    private var body:Data? {
        switch self {
        case .Domains:
            break
        case .Check:
            break
        case .Privileges:
            break
        case .LogIn:
            return authParameters.toJSONData()
        case .LogInWithKey:
            let apikeyDict = [ "api_key" : apiKey ]
            return apikeyDict.toJSONData()
        case .LogOut:
            break
        }
        
        return nil
    }
   
    var description:String {
        switch self {
        case .Domains:
            return "Get All domains for auth without session"
        case .Check:
            return "Check session state"
        case .Privileges:
            return "Get current user privileges"
        case .LogIn:
            return "Log in to system and obtain session identifier. Pass sessionId in 'X-Session-ID' header in all other API requests"
        case .LogInWithKey:
            return "Log in to system using API-key and obtain session identifier. Pass sessionId in 'X-Session-ID' header in all other API requests"
        case .LogOut:
            return "Log out of system"
        }
    }
}
