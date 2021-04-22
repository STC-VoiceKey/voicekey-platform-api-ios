//
//  GroupCheckView.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 09.02.2021.
//

import SwiftUI

struct GroupCheckView: View {
    @State private var group: String = ""
    @State private var result:String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center){
                Spacer()
                TextField("Enter group id", text: $group).padding().frame(width: 220).multilineTextAlignment(.center)
                Spacer()
            }.padding(.top,10)
            Divider().padding(.horizontal,16)
            
            Button(action: {
                result = ""
                
                let groupService = GroupServiceImplementation()
                groupService.checkGroup(withGroup: group) { (res) in

                    update(res)
                }
            }, label: {
                Text("Check Group")
            }).buttonStyle(ActionButtonStyle())
            
            Text("\(result)").padding()
            Spacer()
        }.navigationTitle("Check Group")
    }
    
    private func update(_ res:Any?){
        
        guard !(res is Error) else {
//            let resError
//            result = "\()"
            return
        }
        
        let dict  = res as! Dictionary<String,Any>
        
        dict.reduce(into: [String: Any]()) { (res, x) in
            result = result + " \(x.key) = \(x.value)"
        }
        
        print(dict)
    }
}

struct GroupCheckView_Previews: PreviewProvider {
    static var previews: some View {
        GroupCheckView()
    }
}
