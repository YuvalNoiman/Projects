//
//  SignUpView.swift
//  Maintenance
//
//  Created by Yuval Noiman on 4/24/23.
//

import SwiftUI

struct SignUpView: View{
    @EnvironmentObject var appState: AppState
    //@StateObject var websocket = Websocket()
    @EnvironmentObject var websocket: Websocket
    
    @State private var message = ""
    @State private var Email = ""
    @State private var Password = ""
    @State private var RePassword = ""
    @State private var FirstName: String = ""
    @State private var LastName: String = ""
    @State private var CWID: String = ""
    @State private var Phone: String = ""
    @State private var x = false
    @State private var y = false
    @State private var z = false
    var body: some View{
        TabView(){
            Form{
                Section (header: Text("Email").font(.headline).foregroundColor(Color.blue)){
                    TextField(text: $Email, prompt: Text("Enter A Email: Required").foregroundColor(Color.red)) {
                        Text("Email")
                    }
                    .textInputAutocapitalization(.never)
                }
                Section (header: Text("Password").font(.headline).foregroundColor(Color.blue)){
                    TextField(text: $Password, prompt: Text("Create A Password: Required").foregroundColor(Color.red)) {
                        Text("Password")
                    }
                    .textInputAutocapitalization(.never)
                    TextField(text: $RePassword, prompt: Text("Reenter Password: Required").foregroundColor(Color.red)) {
                        Text("RePassword")
                    }
                    .textInputAutocapitalization(.never)
                }
                //section that gets First Name
                Section (header: Text("First Name and Last Name").font(.headline).foregroundColor(Color.blue)){
                    TextField(text: $FirstName, prompt: Text("Enter First Name: Required").foregroundColor(Color.red)) {
                        Text("First Name")
                    }
                    .textInputAutocapitalization(.never)
                    TextField(text: $LastName, prompt: Text("Enter Last Name: Required").foregroundColor(Color.red)) {
                        Text("Last Name")
                    }
                    .textInputAutocapitalization(.never)
                }
                //section that gets CWID
                Section (header: Text("CWID").font(.headline).foregroundColor(Color.blue)){
                    TextField(text: $CWID, prompt: Text("Required").foregroundColor(Color.red)) {
                        Text("CWID")
                    }
                    .textInputAutocapitalization(.never)
                }
                //section that gets Phone Number
                Section (header: Text("Phone Number").font(.headline).foregroundColor(Color.blue)){
                    TextField(text: $Phone, prompt: Text("Optional").foregroundColor(Color.green)) {
                        Text("Phone Number")
                    }
                    .textInputAutocapitalization(.never)
                }
                
                Section{
                    HStack {
                        Button(action: {
                            print("Create Account")
                            if (Password != RePassword || Password == "" || RePassword == ""){
                                z = true
                            }
                            else if (FirstName == "" || LastName == "" || CWID.count != 9 || Email.contains("@") == false || Int(CWID) == nil){
                                z = false
                                y = true
                            }
                            else {
                                z = false
                                y = false
                                x = true
                                appState.SavedEmail = Email
                                appState.SavedPassword = Password
                                appState.SavedCWID = CWID
                                //send message
                                //message = "Signup Attempt:" + Email + ":," + Password + ":," + FirstName + ":," + LastName + ":," + CWID +":," + Phone
                               /* message += "Signup Attempt:"
                                message += Email
                                message += ":,"
                                message += Password
                                message += ":,"
                                message += FirstName
                                message += ":,"
                                message += LastName
                                message += ":,"
                                message += CWID
                                message += ":,"
                                if (Phone == ""){
                                   message += "null"
                                }
                                else{
                                    message += Phone
                                }*/
                                 message += "Signup Attempt"
                                 message += FirstName
                                 message += ":,"
                                 message += LastName
                                 message += ":,"
                                 message += CWID
                                message += ":,"
                                if (Phone == ""){
                                   message += "NULL"
                                }
                                else{
                                    message += Phone
                                }
                                 message += ":,"
                                 message += Email
                                 message += ":,"
                                 message += Password
                                websocket.sendMessage(message)
                                message = ""
                            }
                        }) {
                            Text("Create Account")
                        }
                    }
                    if (z == true){
                        Text("Password is not the same in both areas!")
                    }
                    if (y == true){
                        Text("Enter into all required areas!")
                    }
                    if (x == true){
                        Text("Signed Up! Now go back!")
                    }
                }
            }
            .background(Color.orange)
            .tabItem {
                Label("SignUp", systemImage: "star")
            }
            .toolbarBackground(Color(red: 245/255, green: 185/255, blue: 113/255), for: .tabBar)
            //tab 2
            Form{
                Section (header: Text("Email:").font(.headline).foregroundColor(Color.blue)){
                    Text(verbatim: "johndoe@gmail.com")
                }
                    .foregroundColor(Color.red)
                Section (header: Text("Password").font(.headline).foregroundColor(Color.blue)){
                    Text("1234")
                }
                    .foregroundColor(Color.red)
                Section (header: Text("First Name:").font(.headline).foregroundColor(Color.blue)){
                    Text("John")
                }
                    .foregroundColor(Color.red)
                Section (header: Text("Last Name:").font(.headline).foregroundColor(Color.blue)){
                    Text("Doe")
                }
                    .foregroundColor(Color.red)
                Section (header: Text("CWID:").font(.headline).foregroundColor(Color.blue)){
                    Text("123456789")
                }
                    .foregroundColor(Color.red)
                Section (header: Text("Phone Number:").font(.headline).foregroundColor(Color.blue)){
                    Text("111-111-1111")
                }
                    .foregroundColor(Color.green)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.orange)
            .tabItem {
                Label("Example", systemImage: "diamond")
            }
            .toolbarBackground(Color(red: 245/255, green: 185/255, blue: 113/255), for: .tabBar)
        }
        .background(Color.orange)
        .scrollContentBackground(.hidden)
    }
}
