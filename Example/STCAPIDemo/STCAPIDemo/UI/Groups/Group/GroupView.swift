//
//  GroupView.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 29.01.2021.
//

import SwiftUI
import Combine

struct GroupView: View {
    
    var dataSource = [GroupRequest.List.rawValue:RequestModel(withType: GroupRequest.List.httpMethod,
                                                              withName: GroupRequest.List.shortUrl, withDescr: GroupRequest.List.description),
                      GroupRequest.Create.rawValue:RequestModel(withType: GroupRequest.Create.httpMethod,
                                                                withName: GroupRequest.Create.shortUrl, withDescr: GroupRequest.Create.description),
                      GroupRequest.ListForPerson.rawValue:RequestModel(withType: GroupRequest.ListForPerson.httpMethod,
                                                                      withName: GroupRequest.ListForPerson.shortUrl, withDescr: GroupRequest.ListForPerson.description),
                      GroupRequest.Delete.rawValue:RequestModel(withType: GroupRequest.Delete.httpMethod,
                                                                withName: GroupRequest.Delete.shortUrl, withDescr: GroupRequest.Delete.description),
                      GroupRequest.Check.rawValue:RequestModel(withType: GroupRequest.Check.httpMethod,
                                                               withName: GroupRequest.Check.shortUrl, withDescr: GroupRequest.Check.description),
                      GroupRequest.GroupPersons.rawValue:RequestModel(withType: GroupRequest.GroupPersons.httpMethod,
                                                                      withName: GroupRequest.GroupPersons.shortUrl, withDescr: GroupRequest.GroupPersons.description),
                      GroupRequest.DeletePersonFromGroup.rawValue:RequestModel(withType: GroupRequest.DeletePersonFromGroup.httpMethod,
                                                                               withName: GroupRequest.DeletePersonFromGroup.shortUrl, withDescr: GroupRequest.DeletePersonFromGroup.description),
                      GroupRequest.AddPersonToGroup.rawValue:RequestModel(withType: GroupRequest.AddPersonToGroup.httpMethod,
                                                                          withName: GroupRequest.AddPersonToGroup.shortUrl, withDescr: GroupRequest.AddPersonToGroup.description),
                      GroupRequest.DeletePersonsFromGroup.rawValue:RequestModel(withType: GroupRequest.DeletePersonsFromGroup.httpMethod,
                                                                                withName: GroupRequest.DeletePersonsFromGroup.shortUrl, withDescr: GroupRequest.DeletePersonsFromGroup.description),
                      GroupRequest.AddPersonsToGroup.rawValue:RequestModel(withType: GroupRequest.AddPersonsToGroup.httpMethod,
                                                                                withName: GroupRequest.AddPersonsToGroup.shortUrl, withDescr: GroupRequest.AddPersonsToGroup.description)]
                                            
    var body: some View {
        List {
            NavigationLink(destination: GroupListIView()) {
                RequestView().environmentObject( dataSource[GroupRequest.List.rawValue]!)
            }
            NavigationLink(destination: GroupCreationView()) {
                RequestView().environmentObject( dataSource[GroupRequest.Create.rawValue]!)
            }
            NavigationLink(destination: GroupByPersonView()) {
                RequestView().environmentObject( dataSource[GroupRequest.ListForPerson.rawValue]!)
            }
            NavigationLink(destination: GroupDeleterView()) {
                RequestView().environmentObject( dataSource[GroupRequest.Delete.rawValue]!)
            }
            NavigationLink(destination: GroupCheckView()) {
                RequestView().environmentObject( dataSource[GroupRequest.Check.rawValue]!)
            }
            NavigationLink(destination: GroupPersonsView()) {
                RequestView().environmentObject( dataSource[GroupRequest.GroupPersons.rawValue]!)
            }
            NavigationLink(destination: DeletePersonFromGroupView()) {
                RequestView().environmentObject( dataSource[GroupRequest.DeletePersonFromGroup.rawValue]!)
            }
            NavigationLink(destination: AddPerson2GroupView()) {
                RequestView().environmentObject( dataSource[GroupRequest.AddPersonToGroup.rawValue]!)
            }
            NavigationLink(destination: DeletePersonsFromGroupView()) {
                RequestView().environmentObject( dataSource[GroupRequest.DeletePersonsFromGroup.rawValue]!)
            }
            NavigationLink(destination: AddPersonsFromGroupView()) {
                RequestView().environmentObject( dataSource[GroupRequest.AddPersonsToGroup.rawValue]!)
            }
        }.navigationBarTitle("Group Service Application", displayMode: .large)
    }
}

