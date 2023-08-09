//
//  StartOverView.swift
//  Maintenance
//
//  Created by Yuval Noiman on 4/24/23.
//

import SwiftUI

struct StartOverView: View {
    //App state properties
    @EnvironmentObject var appState: AppState
    
    var body: some View{
        Form{
            Section (header: Text("Start Over").font(.title).foregroundColor(Color.blue)){
                Button(action: {
                    print("Start Again");
                    appState.switchView = .form
                }) {
                    Text("Start Again")
                        .font(.title2)
                        .foregroundColor(Color.blue)
                }
                Button(action: {
                    print("Log Out");
                    appState.switchView = .login
                }) {
                    Text("Log Out")
                        .font(.title2)
                        .foregroundColor(Color.blue)
                }
            }
        }
        .background(Color.orange)
        .scrollContentBackground(.hidden)
  }
}
