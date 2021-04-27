//
//  GroupRequest.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 19.01.2021.
//

import Foundation

enum GroupRequest:String{
    case List
    case Create
    case ListForPerson
    case Delete
    case Check
    case GroupPersons
    case DeletePersonFromGroup
    case AddPersonToGroup
    case DeletePersonsFromGroup
    case AddPersonsToGroup
    
    var groupUrl:String {
        let urlManager = GroupURLProvider()
        let string = urlManager.value as! String
        return string
    }
    
    var personId:String {
        let personProvider = PersonIdProvider()
        return personProvider.stringValue!
    }
    
    var groupId:String {
        let groupProvider = GroupIdProvider()
        return groupProvider.stringValue!
    }
    
    var sessionId:String {
        let sessionProvider = SessionIdProvider()
        return sessionProvider.stringValue!
    }
    
    public var  httpMethod:String {
        switch self {
        case .List, .ListForPerson, .Check, .GroupPersons:
            return "GET"
        case .Create, .AddPersonToGroup, .AddPersonsToGroup:
            return "POST"
        case .Delete, .DeletePersonFromGroup, .DeletePersonsFromGroup:
            return "DELETE"
        }
    }
    var url:URL {
        return URL.init(string: urlString)!
    }
    
    private var urlString:String {
        switch self {
        case .List, .Create:
            return "\(groupUrl)/group"
        case .ListForPerson:
            return "\(groupUrl)/group/groups/\(personId)"
        case .Delete, .Check:
            return "\(groupUrl)/group/\(groupId)"
        case .GroupPersons:
            return "\(groupUrl)/group/\(groupId)/person"
        case .DeletePersonFromGroup, .AddPersonToGroup:
            return "\(groupUrl)/group/\(groupId)/person/\(personId)"
        case .DeletePersonsFromGroup, .AddPersonsToGroup:
            return "\(groupUrl)/group/\(groupId)/persons"
        }
    }
    
    var shortUrl:String {
        switch self {
        case .List,.Create:
        return "/group"
        case .ListForPerson:
        return "/group/groups/{personId}"
        case .Delete, .Check:
            return "/group/{groupId}"
        case .GroupPersons:
            return "/group/{groupId}/person"
        case .DeletePersonFromGroup, .AddPersonToGroup:
            return "/group/{groupId}/person/{personId}"
        case .DeletePersonsFromGroup, .AddPersonsToGroup:
            return "/group/{groupId}/persons"
        }
    }
     
    var request:URLRequest {
        var req = URLRequest.init(url: url)
        req.httpMethod = httpMethod
        req.addValue("application/json", forHTTPHeaderField:"Content-Type")
        req.addValue(sessionId,          forHTTPHeaderField:"X-Session-ID")
        return req
    }
    
    var description:String {
        switch self {
        case .List:
        return "Get list of active groups"
        case .Create:
        return "Create group"
        case .ListForPerson:
        return "Get list of groups with person"
        case .Delete:
        return "Delete group"
        case .Check:
        return "Check group"
        case .GroupPersons:
        return "Get group persons"
        case .DeletePersonFromGroup:
        return "Delete person from group"
        case .AddPersonToGroup:
        return "Add person to group"
        case .DeletePersonsFromGroup:
        return "Delete persons from group"
        case .AddPersonsToGroup:
        return "Add persons to group"
        }
    }
}
