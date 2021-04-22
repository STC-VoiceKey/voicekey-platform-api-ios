//
//  DomainsView.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 13.04.2021.
//

import SwiftUI

struct DomainsView: View {
    @State var dataSource:Array<DomainItem> = []

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(dataSource) { domain in
                HStack{
                    Text("\(domain.id) - \(domain.name)").multilineTextAlignment(.leading).padding(5).padding(Edge.Set.leading, 30)
                    Spacer()
                }
                Divider().padding(.horizontal,16)
            }
            Spacer()
        }
        .padding(.top,25)
        .navigationBarTitle("Session - Domains ").onAppear{
            obtainDomains()
        }
    }
    
    private func obtainDomains() {
        let sessionService = SessionServiceImplementation()
        sessionService.obtainDomains { (result) in
            let array = result as! Array<Dictionary<String,Any>>
            
            for elem in array {
                let id = elem["id"] as! Int
                let name = elem["name"] as! String
                let gi = DomainItem(identifier: id, name: name)
                self.dataSource.append(gi)
            }
        }
    }
}

struct DomainItem:Identifiable{
    var id: Int { identifier }
    var identifier: Int
    var name:String
}
