//
//  MediaStorageView.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 25.12.2020.
//

import SwiftUI

struct MediaStorageView: View {
    var body: some View {
    List {
        RequestView().environmentObject(RequestModel(withType: "POST",   withName: "/resource",    withDescr: "Put file"))
        RequestView().environmentObject(RequestModel(withType: "GET",    withName: "/resource/types", withDescr: "Get all registred types"))
       
        RequestView().environmentObject(RequestModel(withType: "DELETE", withName: "/resource",    withDescr: "Log out of system"))
        RequestView().environmentObject(RequestModel(withType: "GET",    withName: "/resource",    withDescr: "Check session state"))
        RequestView().environmentObject(RequestModel(withType: "POST",   withName: "/resource",
                                                     withDescr: "Log in to system and obtain session identifier. Pass sessionId in 'X-Session-ID' header in all other API requests"))
        
        RequestView().environmentObject(RequestModel(withType: "POST",   withName: "/session/key",
                                                     withDescr: "Log in to system using API-key and obtain session identifier. Pass sessionId in 'X-Session-ID' header in all other API requests")).background(Color.green)
    }.navigationBarTitle("Session")
     .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    .background(Color.appBackgroundColor)
    }
}

struct MediaStorageView_Previews: PreviewProvider {
    static var previews: some View {
        MediaStorageView()
    }
}
