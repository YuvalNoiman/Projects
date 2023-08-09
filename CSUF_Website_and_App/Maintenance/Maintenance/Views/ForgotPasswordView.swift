//
//  ForgotPasswordView.swift
//  Maintenance
//
//  Created by Yuval Noiman on 4/24/23.
//

import SwiftUI

struct ForgotPasswordView: View{
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var websocket: Websocket
    
    @State private var message = ""
    @State private var Email = ""
    @State private var x = false
    @State private var y = false
    var body: some View{
        Form{
            Section (header: Text("Enter Email").font(.headline).foregroundColor(Color.blue)){
                TextField(text: $Email, prompt: Text("Enter Email: Required").foregroundColor(Color.red)) {
                    Text("Email")
                }
                .textInputAutocapitalization(.never)
            }
            Section{
                HStack {
                    Button(action: {
                        print("Get Password")
                        if (appState.SavedEmail == Email){
                            x = true
                            y = false
                            message += "PassGet:"
                            message += Email
                            websocket.sendMessage(message)
                            websocket.messages = ""
                            websocket.receiveMessage()
                            message = websocket.returnMessages()
                        }
                        else {
                            y = true
                            x = false
                        }
                    }) {
                        Text("Get Password")
                    }
                }
                if (x == true){
                    //Text("Email Sent!")
                    Text(appState.SavedPassword)
                }
                if (y == true){
                    Text("Email does not exist! Create Account")
                }
            }

        }
        .background(Color.orange)
        .scrollContentBackground(.hidden)
    }
}
