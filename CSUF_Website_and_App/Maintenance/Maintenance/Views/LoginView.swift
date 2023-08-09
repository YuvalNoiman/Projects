//
//  LoginView.swift
//  Maintenance
//
//  Created by Yuval Noiman on 4/24/23.
//

import SwiftUI

struct LoginView: View {
    //App state properties
    @EnvironmentObject var appState: AppState
    //@StateObject var websocket = Websocket()
    @EnvironmentObject var websocket: Websocket
    
    @State private var message = ""
    @State private var Email = ""
    @State private var Password = ""
    @State private var x = false
    
        var body: some View{
            NavigationView{
            Form{
                Section (header: Text("Email and  Password").font(.headline).foregroundColor(Color.blue)){
                    TextField(text: $Email, prompt: Text("Enter Email: Required").foregroundColor(Color.red)) {
                        Text("Email")
                    }
                    .textInputAutocapitalization(.never)
                    TextField(text: $Password, prompt: Text("Enter Password: Required").foregroundColor(Color.red)) {
                        Text("Password")
                    }
                    .textInputAutocapitalization(.never)
                }
                Section{
                    HStack {
                        Button(action: {
                            print("Log In")
                            message += "Login Attempt"
                            message += Email
                            message += ":,"
                            message += Password
                            websocket.sendMessage(message)
                            //websocket.messages = ""
                            //websocket.receiveMessage()
                            //print(websocket.messages)
                            //message = websocket.messages
                            Task{
                                await MainActor.run {
                                    websocket.receiveMessage()
                                    message = websocket.returnMessages()
                                }
                            }
                            //message = websocket.returnMessages()
                            if ((Email == appState.SavedEmail) && (Password == appState.SavedPassword) || (message.contains("Valid Login:"))){
                            x = false
                            message = ""
                            appState.switchView = .form
                            }
                            else{
                                x = true
                            }
                        }) {
                            Text("Log In")
                        }
                    }
                    HStack {
                        NavigationLink(destination: SignUpView()){
                            Text("Sign Up")
                                .foregroundColor(.blue)
                        }
                    }
                    HStack {
                        NavigationLink(destination: ForgotPasswordView()){
                            Text("Forgot Password")
                                .foregroundColor(.blue)
                        }
                    }
                    if (x == true){
                        Text("Incorrect! Try Again!")
                    }
                }
            }
            .background(Color.orange)
            .scrollContentBackground(.hidden)
        }
    }
}
