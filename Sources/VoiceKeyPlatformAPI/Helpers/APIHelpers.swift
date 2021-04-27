//
//  APIHelpers.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 01.12.2020.
//

import Foundation

extension Dictionary{
    func json() -> String {
        do{
            let jsonData:Data =  try JSONSerialization.data(withJSONObject:self, options: JSONSerialization.WritingOptions(rawValue:0))
            return NSString( data:jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        }
        catch{
        }
        
        return String()
    }
}

extension Dictionary{
    func toJSON() -> String {
        do{
            let jsonData:Data =  try JSONSerialization.data(withJSONObject:self, options: JSONSerialization.WritingOptions(rawValue:0))
            return NSString( data:jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        }
        catch{
            print(error)
        }
        
        return String()
    }
    
    func toJSONData() -> Data {
        do{
            return try JSONSerialization.data(withJSONObject:self, options: JSONSerialization.WritingOptions(rawValue:0))
        }
        catch{
            print(error)
        }
        
        return Data()
    }
}

extension Dictionary  where Key == String {
    func toError() -> Error {
        let reason  = self["reason"]  ?? "Unknown" as! Value
        let message = self["message"] ?? "Unknown" as! Value
        
        let resultError = NSError( domain:"",
                                     code:101,
                                userInfo: [ NSLocalizedFailureReasonErrorKey:reason,
                                                   NSLocalizedDescriptionKey:message])
        return resultError
    }
}

extension HTTPURLResponse{
    func isSuccess() -> Bool {
        return (self.statusCode == 200 || self.statusCode == 204) ? true : false
    }
}

extension Data {
    func toJSON() -> Any{
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            return json 
        } catch {
            print(error)
        }
        
        return Dictionary<String, Any>()
    }
    
    
//    func toJSON() -> Dictionary<String, Any>{
//        do {
//            let json = try JSONSerialization.jsonObject(with: self, options: [])
//            return json as! Dictionary<String, Any>
//        } catch {
//            print(error)
//        }
//
//        return Dictionary<String, Any>()
//    }
//
//    func toJSONArray() -> Array<Dictionary<String, Any>>{
//        do {
//            let json = try JSONSerialization.jsonObject(with: self, options: [])
//            return json as! Array<Dictionary<String, Any>>
//        } catch {
//            print(error)
//        }
//
//        return Array<Dictionary<String, Any>>()
//    }
}

