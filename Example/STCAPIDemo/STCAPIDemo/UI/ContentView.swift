//
//  ContentView.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 01.12.2020.
//

import SwiftUI

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}

struct ContentView: View {
    
 
    var body: some View {
        NavigationView {
            VStack( spacing: 25) {
                GroupBox(label: Text("SessionService Application"),
                       content: {}).groupBoxStyle(GroupBoxCardStyle(destination: SessionView(), subtext: "Managing sessions"))
                GroupBox(label: Text("MediaStorage Component"),
                       content: {}).groupBoxStyle(GroupBoxCardEnabledStyle(destination: ComingSoonView(), subtext: "is a media storage that stores face images and audio data obtained during client registration"))

                GroupBox(label: Text("GroupService Application"),
                         content: {}).groupBoxStyle(GroupBoxCardEnabledStyle(destination:  ComingSoonView(), subtext: "Managing groups of persons"))
//                GroupBox(label: Text("GroupService Application"),
//                         content: {}).groupBoxStyle(GroupBoxCardStyle(destination:  GroupServiceView(), subtext: "Managing groups of persons"))
                Spacer()
            }.offset(y:25)
            .navigationBarTitle("VoiceKey Portal", displayMode: .large)
            .padding(.top, 55)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    SessionSwitcherView()
                }
            }
            .frame(width: 420,height: 800)
            .background(Color.Gainsborough).padding(0)
        }
        .onAppear{
            clearSession()
            
            let appearance = navigationBarAppearance()
            UINavigationBar.appearance().standardAppearance   = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    private func clearSession() {
        SessionIdProvider().clear()
    }
    
    func navigationBarAppearance() -> UINavigationBarAppearance  {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.SmokyWhite
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.BlackGray as Any]
        appearance.shadowColor = UIColor.SmokyWhite
        appearance.shadowImage = UIImage(named: "naviBarShadow")
        return appearance
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
}


