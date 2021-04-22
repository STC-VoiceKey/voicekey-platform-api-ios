//
//  GroupServiceView.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 19.04.2021.
//

import SwiftUI

struct GroupServiceView: View {
    var body: some View {
        VStack(alignment: .center) {
            HStack { Spacer() }
            NavigationLink(destination: GroupView()) {
                Text("Face Processor").TextServiceLinkStyle()
            }.NotImplementedYetLinkStyle().disabled(true)
            NavigationLink(destination: GroupView()) {
                Text("Group").TextServiceLinkStyle()
            }.ServiceLinkStyle()
            NavigationLink(destination: GroupView()) {
                Text("VoiceGrid Processor").TextServiceLinkStyle()
            }.NotImplementedYetLinkStyle().disabled(true)
        }
        .navigationBarTitle("GroupService", displayMode: .large).padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.white)
    }
}

struct GroupServiceView_Previews: PreviewProvider {
    static var previews: some View {
        GroupServiceView()
    }
}
