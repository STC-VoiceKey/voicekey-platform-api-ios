//
//  SessionService.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 01.12.2020.
//

import Foundation

typealias CompletionHandler = (Any?) -> Void
typealias DataTaskHandler   = (Data?, Error?, CompletionHandler?) -> Void

protocol SessionService{
    
    func logIn(_ completion: @escaping CompletionHandler)
    func logInWithKey(_ completion: @escaping CompletionHandler)
    func check(_ completion: @escaping CompletionHandler)
    func logOut(_ completion: @escaping CompletionHandler)
    func obtainDomains(_ completion: @escaping CompletionHandler)
    func obtainPrivileges(withComponents components:Array<String>, completion: @escaping CompletionHandler)
}

class SessionServiceImplementation: SessionService {
    let session = URLSession.shared
    
    var completition4JSONDate:DataTaskHandler = { (data, error, completion) in
        guard error == nil else {
            completion!(error)
            return
        }
        let jsonData = data?.toJSON()
        let dict = jsonData as? Dictionary< String, Any>
        
        guard (dict == nil) else {
            guard !(dict?["reason"] != nil) else {
                completion!(dict?.toError())
                return
            }
            completion?(dict)
            return
        }
        
        completion!(jsonData)
    }
    
    func logIn(_ completion: @escaping CompletionHandler) {
        let task = session.dataTask(with: SessionRequest.LogIn.request) { (data, responce, error) in
            self.completition4JSONDate(data,error,completion)
        }
        task.resume()
    }
    
    func logInWithKey(_ completion: @escaping CompletionHandler) {
        let task = session.dataTask(with: SessionRequest.LogInWithKey.request) { (data, responce, error) in
            self.completition4JSONDate(data,error,completion)
        }
        task.resume()
    }
    
    func check(_ completion: @escaping CompletionHandler) {
        let task = session.dataTask(with: SessionRequest.Check.request) { (data, responce, error) in
            self.completition4JSONDate(data,error,completion)
        }
        task.resume()
    }
    
    func logOut(_ completion: @escaping CompletionHandler) {
        let task = session.dataTask(with: SessionRequest.LogOut.request ) { (data, responce, error) in
            self.completition4JSONDate(data,error,completion)
        }
        task.resume()
    }
    
    func obtainDomains(_ completion: @escaping CompletionHandler) {
        let task = session.dataTask(with: SessionRequest.Domains.request) { (data, responce, error) in
            self.completition4JSONDate(data,error,completion)
        }
        task.resume()
    }
    
    func obtainPrivileges(withComponents components:Array<String>,completion: @escaping CompletionHandler) {
        var req = SessionRequest.Privileges.request
        req.httpBody = ["names":components].toJSONData()
        
        let task = session.dataTask(with: req) { (data, responce, error) in
            self.completition4JSONDate(data,error,completion)
        }
        task.resume()
    }
}
