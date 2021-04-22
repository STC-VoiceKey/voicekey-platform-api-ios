//
//  DeletePersonFromGroupView.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 11.02.2021.
//

import SwiftUI

struct DeletePersonFromGroupView: View {
    @State private var group: String = ""
    @State private var person: String = ""
    @State private var result:String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center){
                Spacer()
                TextField("Enter group id", text: $group).padding().frame(width: 220).multilineTextAlignment(.center)
                Spacer()
            }.padding(.top,10)
            Divider().padding(.horizontal,16)
            HStack(alignment: .center){
                Spacer()
                TextField("Enter person id", text: $person).padding().frame(width: 220).multilineTextAlignment(.center)
                Spacer()
            }.padding(.top,10)
            Divider().padding(.horizontal,16)
            
            Button(action: {
                let groupService = GroupServiceImplementation()
                groupService.delete(person: person, fromGroup: group) { (res) in
                    result = "\(res)"
                }
            }, label: {
                Text("Delete Person From Group")
            }).buttonStyle(ActionButtonStyle())
            
            
            Text("\(result)").multilineTextAlignment(.leading).padding()
            Spacer()
        }
    }
}

struct DeletePersonFromGroupView_Previews: PreviewProvider {
    static var previews: some View {
        DeletePersonFromGroupView()
    }
}