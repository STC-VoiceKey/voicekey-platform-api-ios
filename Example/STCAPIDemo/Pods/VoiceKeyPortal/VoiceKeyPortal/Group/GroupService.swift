//
//  GroupService.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 04.02.2021.
//

import Foundation

protocol GroupService {
    func obtainList(_ completion: @escaping CompletionHandler)
    func createGroup(_ name:String, completion: @escaping CompletionHandler)
    func obtainList(forPerson person:String,_ completion: @escaping CompletionHandler)
    func deleteGroup(withGroup group:String,_ completion: @escaping CompletionHandler)
    func checkGroup(withGroup group:String,_ completion: @escaping CompletionHandler)
    func obtainGroupPerson(withGroup group:String,_ completion: @escaping CompletionHandler)
    func delete(person:String ,fromGroup group:String,_ completion: @escaping CompletionHandler)
    func add(person:String ,toGroup group:String,_ completion: @escaping CompletionHandler)
}

class GroupServiceImplementation:  GroupService {
    let session = URLSession.shared
    
    /*
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
 
 completion!(jsonData)*/
    
    func toLocalError(_ data:Data?,_ error:Error?) -> Error? {
        guard error == nil else {
            return error
        }
        
        let jsonData = data?.toJSON()
        let dict = jsonData as? Dictionary< String, Any>
        
        guard (dict == nil) else {
            guard !(dict?["reason"] != nil) else {
                return dict?.toError()
            }
            return nil
        }
        return nil
    }
    
    func obtainList(_ completion: @escaping CompletionHandler) {
        let task = session.dataTask(with: GroupRequest.List.request) { [self] (data, responce, error) in
            let localError = self.toLocalError(data,error)
            guard localError == nil else {
                completion(localError)
                return
            }
            
            let groups = data?.toJSON() as! Array<Dictionary<String, Any>>
            let adapter = GroupListAdapterImplementation(groups)
            completion(adapter.groups)
        }
        task.resume()
    }
    
    func createGroup(_ name:String, completion: @escaping CompletionHandler) {
        var request = GroupRequest.Create.request
        request.httpBody =  ["name":name].toJSONData()
        
        let task = session.dataTask(with: request){ (data, responce, error) in
            let localError = self.toLocalError(data,error)
            guard localError == nil else {
                completion(localError)
                return
            }
            let group = data?.toJSON()
           completion(group)
        }
        task.resume()
    }
    
    func obtainList(forPerson person: String, _ completion: @escaping CompletionHandler) {
        setup(withPerson: person)
        
        let task = session.dataTask(with: GroupRequest.ListForPerson.request){ (data, responce, error) in
            let localError = self.toLocalError(data,error)
            guard localError == nil else {
                completion(localError)
                return
            }
            let group = data?.toJSON() as! Array<Dictionary<String, Any>>
           completion(group)
        }
        task.resume()
    }
    
    
    func deleteGroup( withGroup group:String, _ completion: @escaping CompletionHandler) {
        setup(withGroup: group)
        let task = session.dataTask(with: GroupRequest.Delete.request){ (data, responce, error) in
            let localError = self.toLocalError(data,error)
            guard localError == nil else {
                completion(localError)
                return
            }
            let resp:HTTPURLResponse = responce as! HTTPURLResponse
            if resp.isSuccess() {
                completion(["message":"Deleted"])
            }
        }
        task.resume()
        
    }
    
    func checkGroup(withGroup group: String, _ completion: @escaping CompletionHandler) {
        setup(withGroup: group)

        let task = session.dataTask(with: GroupRequest.Check.request){ (data, responce, error) in
            let localError = self.toLocalError(data,error)
            guard localError == nil else {
                completion(localError)
                return
            }
           completion(data?.toJSON())
        }
        task.resume()
    }
    
    func obtainGroupPerson(withGroup group:String,_ completion: @escaping CompletionHandler) {
        setup(withGroup: group)

        let task = session.dataTask(with: GroupRequest.GroupPersons.request){ (data, responce, error) in
            let localError = self.toLocalError(data,error)
            guard localError == nil else {
                completion(localError)
                return
            }
           completion(data?.toJSON as! Array<Dictionary<String, Any>>)
        }
        task.resume()
   }
   
    func add(person: String, toGroup group: String, _ completion: @escaping CompletionHandler) {
        setup(withPerson: person)
        setup(withGroup: group)
        
        let task = session.dataTask(with: GroupRequest.AddPersonToGroup.request){ (data, responce, error) in
            let localError = self.toLocalError(data,error)
            guard localError == nil else {
                completion(localError)
                return
            }
            let resp:HTTPURLResponse = responce as! HTTPURLResponse
            if resp.isSuccess() {
                completion(["message":"Add complited"])
            }
        }
        task.resume()
    }
    
    func delete(person: String, fromGroup group: String, _ completion: @escaping CompletionHandler) {
        setup(withPerson: person)
        setup(withGroup: group)

        let task = session.dataTask(with: GroupRequest.DeletePersonFromGroup.request){ (data, responce, error) in
            let localError = self.toLocalError(data,error)
            guard localError == nil else {
                completion(localError)
                return
            }
            let resp:HTTPURLResponse = responce as! HTTPURLResponse
            if resp.isSuccess() {
                completion(["message":"Delete complited"])
            }
        }
        task.resume()
    }
    
    private func setup( withPerson person:String) {
        let personIDProvider = PersonIdProvider()
        personIDProvider.update(person)
        personIDProvider.save()
    }
    
    private func setup( withGroup group:String) {
        let groupProvider = GroupIdProvider()
        groupProvider.update(group)
        groupProvider.save()
    }
}
