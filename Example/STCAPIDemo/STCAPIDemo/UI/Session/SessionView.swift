//
//  SessionPage.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 03.12.2020.
//

import SwiftUI
import Combine
import VoiceKeyPlatformAPI

struct SessionView: View {
    @State var isSessionExists = false
    
    var dataSource = [SessionRequest.Domains.rawValue:RequestModel(withType: SessionRequest.Domains.httpMethod,
                                                                   withName: SessionRequest.Domains.shortUrlString,      withDescr: SessionRequest.Domains.description),
                   SessionRequest.Privileges.rawValue:RequestModel(withType: SessionRequest.Privileges.httpMethod,
                                                                   withName: SessionRequest.Privileges.shortUrlString,   withDescr: SessionRequest.Privileges.description),
                       SessionRequest.LogOut.rawValue:RequestModel(withType: SessionRequest.LogOut.httpMethod,
                                                                   withName: SessionRequest.LogOut.shortUrlString,       withDescr: SessionRequest.LogOut.description),
                        SessionRequest.Check.rawValue:RequestModel(withType: SessionRequest.Check.httpMethod,
                                                                   withName: SessionRequest.Check.shortUrlString,        withDescr: SessionRequest.Check.description),
                        SessionRequest.LogIn.rawValue:RequestModel(withType: SessionRequest.LogIn.httpMethod,
                                                                   withName: SessionRequest.LogIn.shortUrlString,        withDescr: SessionRequest.LogIn.description),
                 SessionRequest.LogInWithKey.rawValue:RequestModel(withType: SessionRequest.LogInWithKey.httpMethod,
                                                                   withName: SessionRequest.LogInWithKey.shortUrlString, withDescr: SessionRequest.LogInWithKey.description) ]

    
    @State private var selectedAlert: Warning?
    
    let sessionService = SessionServiceImplementation()

    var body: some View {
         List {
            NavigationLink(destination: DomainsView()) {
                RequestView().environmentObject( dataSource[ SessionRequest.Domains.rawValue ]! )
            }
            NavigationLink(destination: PrivilegesView()) {
                RequestView().environmentObject( dataSource[ SessionRequest.Privileges.rawValue ]! )
            }
            RequestView().environmentObject( dataSource[ SessionRequest.LogOut.rawValue ]! ).onTapGesture {
                sessionService.logOut { (result) in
                    guard !(result is Error) else {
                        self.show(result as! Error)
                        return
                    }
                    selectedAlert = Warning(name: "Log Out", message: "Session closed")
                }
            }
            RequestView().environmentObject( dataSource[ SessionRequest.Check.rawValue ]! ).onTapGesture {
                sessionService.check { (result) in
                    guard !(result is Error) else {
                        self.show(result as! Error)
                        return
                    }
                    let resultDict = result as! Dictionary<String,Any>
                    let isActive = resultDict["is_active"] as! Bool
                    
                    selectedAlert = Warning(name: "Check session", message: "Session is \(isActive ? "active" : "closed")")
                }
            }
            RequestView().environmentObject( dataSource[ SessionRequest.LogIn.rawValue ]! ).onTapGesture {
                sessionService.logIn { (result) in
                    guard !(result is Error) else {
                        self.show(result as! Error)
                        return
                    }
                    let resultDict = result as! Dictionary<String,Any>
                    let session_id = resultDict["session_id"] as! String
                    selectedAlert = Warning(name: "Session is", message: "\(session_id)")
                }
            }
            RequestView().environmentObject(dataSource[ SessionRequest.LogInWithKey.rawValue ]!).onTapGesture {
                sessionService.logInWithKey{ (result) in
                    guard !(result is Error) else {
                        self.show(result as! Error)
                        return
                    }
                    let resultDict = result as! Dictionary<String,Any>
                    let session_id = resultDict["session_id"] as! String
                    selectedAlert = Warning(name: "Session is", message: "\(session_id)")
                }
            }
        }.navigationBarTitle("Session").onAppear{
            let sessionProvider = SessionIdProvider()
            isSessionExists = (sessionProvider.value != nil)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.Gainsborough)
        .alert(item: $selectedAlert) { (alert) -> Alert in
            Alert(title: Text(alert.name), message: Text(alert.message), dismissButton: .cancel())
         }
    }
    
    private func show(_ error:Error) {
        let nsError = error as? NSError
        selectedAlert = Warning(name: nsError?.localizedFailureReason ?? "", message: error.localizedDescription)
    }
}

struct Warning: Identifiable {
    var id: String { name }
    let name: String
    let message:String
}
