//
//  BaseService.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 22.04.2021.
//

import Foundation


class BaseService {
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
}
