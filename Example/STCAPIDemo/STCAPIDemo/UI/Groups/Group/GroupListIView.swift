//
//  GroupListIView.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 02.02.2021.
//

import SwiftUI
import Combine

struct GroupListIView: View {
    @State var groupList:Array<GroupItem> = []

    var body: some View {
        ScrollView() {
            ForEach(groupList) { group in
                HStack{
                    Text("\(group.name)").multilineTextAlignment(.leading).padding(5).padding(Edge.Set.leading, 30)
                    Spacer()
                }
                Divider().padding(.horizontal,16)
            }
        }.padding(.top,20)
        .onAppear{
            let groupService = GroupServiceImplementation()
            groupService.obtainList { (result) in
                let array = result as! Array<String>
                
                for elem in array {
                    let gi = GroupItem(name: elem)
                    print(gi)
                    self.addGroup(gi)
                }
            }
        }.navigationBarTitle("List of active groups", displayMode: .inline)
    }
    
    private func addGroup(_ group:GroupItem) {
        self.groupList.append(group)
    }
}

struct GroupItem:Identifiable{
    var id: String { name }
    var name: String
}
