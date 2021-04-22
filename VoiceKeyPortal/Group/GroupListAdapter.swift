//
//  GroupListAdapter.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 05.02.2021.
//

import Foundation

protocol GroupListAdapter {
    init(_ result:Array<Dictionary<String, Any>>)
    var groups:Array<String>? { get }
}

class GroupListAdapterImplementation: GroupListAdapter {
    
    var source:Array<Dictionary<String, Any>>
    required init(_ result: Array<Dictionary<String, Any>>) {
        source = result
    }
    
    var groups:Array<String>? {
        get {
            var result:Array<String>? = Array()
            for group in source {
                let name = group["name"] as! String
                result?.append(name)
            }
            return result
        }
    }

}
