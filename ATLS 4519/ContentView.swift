//
//  ContentView.swift
//  ATLS 4519
//
//  Created by Quentin Wingard on 9/9/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var toggleIsOn: Bool = false
    
    var body: some View {
        VStack{
            
            Toggle(
                isOn: $toggleIsOn,
                label: {
                    Text("Status")
                    Text(toggleIsOn ? "Online" : "Offline")
                    
                })
            .toggleStyle(SwitchToggleStyle(tint:Color.purple))
            Spacer()
            
            Ellipse()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Ellipse()
                .foregroundColor(.white)
            Ellipse()
                .foregroundColor(.red)
        }
        
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
