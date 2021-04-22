//
//  UserDefaultsHelper.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 01.12.2020.
//

import Foundation

class UserDefaultsHelper: NSObject {
    public private(set) var key:String?
    public private(set) var value:Any? {
        get {
            return UserDefaults.standard.object(forKey: self.key!)
        }
        set {}
    }
    
    public private(set) var stringValue:String? {
        get {
            return UserDefaults.standard.object(forKey: self.key!) as? String
        }
        set {}
    }
    
    private var nvalue:Any?
    
    func save() {
        print("save \(String(describing: self.nvalue)) as \(String(describing: self.key))")
        UserDefaults.standard.set(self.nvalue, forKey: self.key!)
        UserDefaults.standard.synchronize()
    }
    
    func update(_ newValue:Any){
        print("update \(String(describing: newValue)) as \(String(describing: self.key))")
        self.nvalue = newValue
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: key!)
    }
}
