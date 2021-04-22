//
//  GroupPersonsView.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 09.02.2021.
//

import SwiftUI

struct GroupPersonsView: View {
    @State private var group: String = ""
    @State var personList:Array<PersonItem> = []
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center){
                Spacer()
                TextField("Enter group id", text: $group).padding().frame(width: 220).multilineTextAlignment(.center)
                Spacer()
            }.padding(.top,10)
            Divider().padding(.horizontal,16)
            
            Button(action: {
                let groupService = GroupServiceImplementation()
                groupService.obtainGroupPerson(withGroup: group) { (result) in
                    let array = result as! Array<Dictionary<String,Any>>
                    print(array)
                    
                    for elem in array {
                        let personId = elem["person_id"] as! String
                        print(personId)
                       let pi = PersonItem(ident: personId)

                       self.addPerson(pi)
                    }
                }
            }, label: {
                Text("Get Groups by Person")
            }).buttonStyle(ActionButtonStyle())
            
            ForEach(personList) { person in
                Text("\(person.ident)").multilineTextAlignment(.leading).padding()
            }
            Spacer()
        }.navigationTitle("Groups by Person")
    }
    
    func addPerson(_ person:PersonItem) {
        personList.append(person)
    }
}

struct PersonItem:Identifiable{
    var id: String { ident }
    var ident:String
}

struct GroupPersonsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupPersonsView()
    }
}
