//
//  SessionSwitcherView.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 13.04.2021.
//

import SwiftUI
import VoiceKeyPortal

struct SessionSwitcherView: View {
    
    static let kTapToStartSession = "Tap to Start Session"
    
    @State private var isSessionExists: Bool = false
    @State private var isSessionRequesting:Bool = false
    @State private var sessionId:String = kTapToStartSession
    
    var body: some View {

        Button(action: { doAction() }) {
            Image(systemName: "power").foregroundColor( self.isSessionExists ? Color.Mint : (isSessionRequesting ? Color.corporateYellow : Color.LuminescentRed ) ).font(.system(size: 20, weight: .medium))
            Text(sessionId).fontWeight(.light).font(.system(size: 17)).foregroundColor(self.isSessionExists ? Color.Mint : (isSessionRequesting ? Color.corporateYellow : Color.LuminescentRed ))
        }.frame(width: 420)
       
    }
    
    private func doAction() {
        let sessionService = SessionServiceImplementation()

        if isSessionExists {
            sessionService.logOut { (result) in
                isSessionExists = false
                sessionId = SessionSwitcherView.kTapToStartSession
            }
        } else {
            isSessionRequesting = true
            sessionService.logIn { (result) in
                isSessionRequesting = false
                guard !(result is Error) else {
                    isSessionExists = false
                    return
                }
                isSessionExists = true
                let sessionAdapter:SessionResultAdapter = SessionResultAdapterImplementation(result as! Dictionary<String, Any>)
                sessionId = sessionAdapter.sessionId!
                save(sessionAdapter.sessionId!)
            }
        }
    }
    
    private func save(_ withSession:String) {
        let saver = SessionIdProvider()
        saver.update(sessionId)
        saver.save()
    }    
}

struct SessionSwitcherView_Previews: PreviewProvider {
    static var previews: some View {
        SessionSwitcherView()
    }
}
