//
//  ContentView.swift
//  Maintenance
//
//  Created by Yuval Noiman on 2/22/23.
//

import UIKit
import SwiftUI

class Websocket: ObservableObject {
    @Published var messages = ""
    //@State var messages = ""
    //var messages = ""
    
    private var webSocketTask: URLSessionWebSocketTask?
    
    init() {
        self.connect()
    }
    
    private func connect() {
        guard let url = URL(string: "ws://127.0.0.1:7000") else { return }
        let request = URLRequest(url: url)
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.resume()
        sendMessage("connected")
    }
    
    func receiveMessage(){
        webSocketTask?.receive { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let message):
                switch message {
                case .string(let text):
                    //print(text)
                    //self.messages.append(text)
                    Task{
                        await MainActor.run {
                            self.messages = text
                            print(self.messages)
                        }
                    }
                    //self.messages = text
                    //print(self.messages)
                case .data(let data):
                    // Handle binary data
                    self.messages.append("data")
                    break
                @unknown default:
                    break
                }
            }
        }
    }
    
    func sendMessage(_ message: String) {
        guard let data = message.data(using: .utf8) else { return }
        webSocketTask?.send(.string(message)) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func returnMessages() -> String {
        return self.messages
    }
}

class AppState: ObservableObject {
    enum CurrentView: Int {
        case login
        case form
        case startover
    }
    
    //@AppStorage("view") var switchView = CurrentView.login
    @AppStorage("name") var SavedEmail = "new"
    @AppStorage("name") var SavedPassword = "new"
    @AppStorage("name") var SavedCWID = "new"
    @Published var switchView = CurrentView.login
}

struct ContentView: View {
    @StateObject var websocket = Websocket()
    @StateObject var appState = AppState()
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    var body: some View {
        Group {
            switch (appState.switchView) {
            case .login:
                LoginView()
                    .environmentObject(appState)
                    .environmentObject(websocket)
                    .transition(transition)
            
            case .form:
                FormView()
                    .environmentObject(appState)
                    .environmentObject(websocket)
                    .transition(transition)
                
            case .startover:
                StartOverView()
                    .environmentObject(appState)
                    .environmentObject(websocket)
                    .transition(transition)
                
            }
        }
        .animation(.default, value: appState.switchView)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
