//
//  RequestView.swift
//  STCAPIDemo
//
//  Created by Soloshcheva Aleksandra Alekseevna on 04.12.2020.
//

import SwiftUI

class RequestModel : ObservableObject {
    
    init(withType type:String, withName name:String, withDescr descr:String) {
        self.type  = type
        self.name  = name
        self.descr = descr
        
        switch type {
        case "GET":
            self.color = Color.TwitterColor
            break
        case "POST":
            self.color = Color.ShinyGreen
            break
        case "DELETE":
            self.color = Color.AlizarinRed
            break
        case "PUT":
            self.color = Color.LightTitian
            break
        default:
            self.color = Color.corporateYellow
        }
    }
    
    @Published var  type:String
    @Published var  name:String
    @Published var  descr:String
    
    var color:Color
}

struct RequestView: View {
    @EnvironmentObject var model: RequestModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: nil, content:{
                VStack(alignment: .center) {
                    Text(model.type).HttpHeaderTextStyle(model.color)
                }
                Text(model.name).frame(width: 250, height: 30, alignment: .bottomLeading)
                Spacer()
            })
            Text(model.descr).font(.system(size: 11,weight: .ultraLight)).italic()  
        }
    }
}

extension Text {
    
    func HttpHeaderTextStyle(_ color:Color) -> some View {
        self.font(.system(size: 14, weight: .bold)).frame(width: 75, height: 24, alignment: .center).foregroundColor(.white).background(color).cornerRadius(4.0)
    }
    
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}
