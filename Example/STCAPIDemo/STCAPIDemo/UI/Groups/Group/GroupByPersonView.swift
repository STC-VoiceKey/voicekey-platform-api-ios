//
//  GroupByPersonView.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 09.02.2021.
//

import SwiftUI

struct GroupByPersonView: View {
    @State private var person:String = ""
    @State var groupList:Array<GroupItem> = []
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center){
                Spacer()
                TextField("Enter person id", text: $person).padding().frame(width: 220).multilineTextAlignment(.center)
                Spacer()
            }.padding(.top,10)
            Divider().padding(.horizontal,16)
            
            Button(action: {
                let groupService = GroupServiceImplementation()
                groupService.obtainList(forPerson: person) { (result) in
                    
                    let array = result as! Array<Dictionary<String,Any>>
                    
                    for elem in array {
                        let gi = GroupItem(name: elem["name"] as! String)
                        print(gi)
                        self.addGroup(gi)
                    }
                }
            }, label: {
                Text("Get Groups by Person")
            }).buttonStyle(ActionButtonStyle())
            
            if groupList.count == 0 {
                HStack{
                    Text("The person has no groups").multilineTextAlignment(.leading).padding(5).padding(Edge.Set.leading, 30)
                    Spacer()
                }
                Spacer()
            } else {
            ScrollView {
                ForEach(groupList) { group in
                    HStack{
                        Text("\(group.name)").multilineTextAlignment(.leading).padding(5).padding(Edge.Set.leading, 30)
                        Spacer()
                    }
                    Divider().padding(.horizontal,16)
                }
            }
            }
        }
    }
    
    private func addGroup(_ group:GroupItem) {
        self.groupList.append(group)
    }
}

struct GroupByPersonView_Previews: PreviewProvider {
    static var previews: some View {
        GroupByPersonView()
    }
}
