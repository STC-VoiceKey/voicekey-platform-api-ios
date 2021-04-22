//
//  PrivilegesView.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 14.04.2021.
//

import SwiftUI

struct PrivilegesView: View {
    @State var dataSource:Array<PrivilegeItem> = []
    @State var isErrorOccuped = false
    @State var currentError:NSError?
    
    @State private var name:String = ""// = "SECURITY"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center){
                Spacer()
                TextField("Enter component name", text: $name).padding().frame(width: 220).multilineTextAlignment(.center)
                Spacer()
            }.padding(.top,10)
            Divider().padding(.horizontal,16)
            Button(action: {
                obtainPrivileges()
            }, label: {
                Text("Get Privileges")
            }).buttonStyle(ActionButtonStyle())
            ScrollView{
                ForEach(dataSource) { pri in
                    HStack {
                        Text("\(pri.name)").padding(5).padding(Edge.Set.leading, 30)
                        Spacer()
                    }
                    Divider().padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
            }.padding(.top,30)
            Spacer()
        }.alert(isPresented: $isErrorOccuped, content: {
            Alert(title: Text(currentError!.localizedFailureReason ?? ""),
                  message: Text(currentError!.localizedDescription), dismissButton: .default(Text("Ok"),
                                                                                             action: {
                    isErrorOccuped = false
                  }))
        })
        
    }
    
    private func obtainPrivileges() {
        dataSource = []
        
        let sessionService = SessionServiceImplementation()
        sessionService.obtainPrivileges(withComponents: [name]) { (result) in
            guard !(result is Error) else {
                currentError = result as? NSError
                isErrorOccuped = true
                return
            }
            
            let dict = result as! Dictionary<String,Any>
            let array = dict[name] as! Array<String>
            
            for elem in array {
                let gi = PrivilegeItem( name: elem)
                self.dataSource.append(gi)
            }
        }
    }
    
}
struct PrivilegeItem:Identifiable{
    var id: String { name }
    var name:String
}
