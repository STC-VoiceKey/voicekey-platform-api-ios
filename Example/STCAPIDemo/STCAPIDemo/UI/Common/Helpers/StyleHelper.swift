//
//  StyleHelper.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 13.04.2021.
//

import SwiftUI

extension Button {
    func ActionButtonStyle() -> some View {
        self.padding(0).background(Color.SkyBlue).cornerRadius(8.0).frame(width: 340, height: 50, alignment: .center)
    }
}



struct ActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
           configuration
               .label
               .font(.system(size: 17))
               .foregroundColor(.white)
               .padding()
               .background( RoundedRectangle(cornerRadius: 8)
                            .fill(Color.SkyBlue).frame(width: 380, height: 60, alignment: .center) )
            .frame(width: 380, height: 60, alignment: .center).offset(x:16)
    }
}

extension NavigationLink {
    func ServiceLinkStyle() -> some View {
        self.padding(0).background(Color.SkyBlue).cornerRadius(10.0).shadow(radius: 5 ).frame(width: 300, height: 100, alignment: .center)
    }
    
    func  NotImplementedYetLinkStyle() ->  some View {
        self.padding(0).background(Color.SkyBlue.opacity(0.6)).cornerRadius(10.0).shadow(radius: 5 )
    }
}

extension Text {
    func TextServiceLinkStyle() -> some View {
        self.frame(width: 300, height: 80, alignment: .center).foregroundColor(.white).font(.system(size: 16))
    }
}

struct ServiceLinkGroupBoxStyle:GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading ){
            configuration.label
                            .font(.system(size: 16, weight: .medium, design: .monospaced))
            
            configuration.content
        }
        .background(RoundedRectangle(cornerRadius: 25)
                        .fill(Color.SkyBlue)
                        .frame(width: 300, height: 160)
                        .shadow(color: Color.DarkBlueCraiola, radius: 10, x: 10.0, y: 10.0)
                        .shadow(color: .MidnightBlueCraiola, radius: 10, x: -5, y: -5))
    }
}

struct NavigationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
           configuration.label.frame(width: 340, height: 120)
            .font(.headline)
            .foregroundColor(Color.SignalBlack)
             .padding()
            .background(RoundedRectangle(cornerRadius: 16)
                            .fill(Color.SnowWhite)
                            .frame(width: 340, height: 120)
                            .shadow(color: Color.CadetBlueCraiola.opacity(0.8), radius: 15, x: 7, y: 7)
                            .shadow(color: Color.SmokyWhite, radius: 10, x: -10, y: -10))
    }
}

struct GroupBoxCardStyle<V: View>:GroupBoxStyle {
    var destination:V
    var subtext:String
    
    func makeBody(configuration: Configuration) -> some View {
        
        NavigationLink(destination: destination) {
            VStack(alignment: .leading,spacing:5) {
                HStack{
                    configuration.label.font(.headline).padding(.leading,15).offset(y:25).multilineTextAlignment(.leading)
                    Spacer()
                }
                Text(subtext).font(.caption).padding(.leading,15).offset(y:25)
                Spacer()
                
            }.frame(width: 380, height: 150).background(RoundedRectangle(cornerRadius: 16)
//                                                            .fill(Color.SnowWhite)
                                                            .fill(LinearGradient(gradient: Gradient(colors: [Color.SnowWhite.opacity(0.7),Color.SnowWhite.opacity(1.0)]),
                                                                                 startPoint: .topLeading, endPoint: .bottomTrailing))
                                                            .frame(width: 380, height: 150)
                                                            .shadow(color: Color.CadetBlueCraiola.opacity(0.8), radius: 15, x: 7, y: 7)
                                                            .shadow(color: Color.SmokyWhite, radius: 10, x: -10, y: -10))
        }.buttonStyle(NavigationButtonStyle())
    }
}

struct GroupBoxCardEnabledStyle<V: View>:GroupBoxStyle {
    var destination:V
    var subtext:String
    
    func makeBody(configuration: Configuration) -> some View {
        
        NavigationLink(destination: destination) {
            VStack(alignment: .leading,spacing:5) {
                HStack{
                    configuration.label.font(.headline).padding(.leading,15).offset(y:25).multilineTextAlignment(.leading)
                    Spacer()
                }
                Text(subtext).font(.caption).padding(.leading,15).offset(y:25)
                Spacer()
                
            }.frame(width: 370, height: 140).background(RoundedRectangle(cornerRadius: 16)
                                                            .fill(LinearGradient(gradient: Gradient(colors: [Color.SnowWhite.opacity(0.2),Color.SnowWhite.opacity(0.4)]),
                                                                                 startPoint: .topLeading, endPoint: .bottomTrailing))
                                                            .frame(width: 370, height: 140)
                                                            .shadow(color: Color.CadetBlueCraiola.opacity(0.8), radius: 10, x: 7, y: 7)
                                                            .shadow(color: Color.SmokyWhite, radius: 5, x: -10, y: -10))
        }
    }
}
