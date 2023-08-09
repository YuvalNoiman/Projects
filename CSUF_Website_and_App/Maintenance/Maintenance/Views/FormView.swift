//
//  FormView.swift
//  Maintenance
//
//  Created by Yuval Noiman on 4/24/23.
//

import SwiftUI

struct FormView: View {
    //App state properties
    @EnvironmentObject var appState: AppState
    //@StateObject var websocket = Websocket()
    @EnvironmentObject var websocket: Websocket
    
    func reset (){
        Emergency = false
        Category = "Pick A Category"
        Location = "Pick A Location"
        Description = ""
        button1 = empty
        button2 = empty
        y = true
    }
    //Variables
    @State private var message = ""
    @State private var CWID = ""
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State private var empty: String = "circle"
    @State private var filled: String = "circle.fill"
    @State private var button1: String = "circle"
    @State private var button2: String = "circle"
    @State private var buttonOn = false
    @State private var Emergency = true
    @State private var Category: String = "Pick A Category"
    @State private var Description: String = ""
    let type = ["Pick A Category","ELECTRICAL", "STRUCTURAL", "HVAC", "FIRE", "HAZARDOUS/WASTE", "SAFETY", "PLUMBING/SEWER", "WATER/IRRIGATION", "ROAD", "SECURITY/FENCE", "CLASSROOM EQUIPMENT", "OTHER"]
    @State private var Location: String = "Pick A Location"
    let place = ["Pick A Location","Arboretum", "Book Store/Titan Shops", "Becker Amphitheater", "Greenhouse Complex", "Children's Center", "Carl's Jr", "College Park", "Clayes Performing Arts Center", "Corporation Yard", "Computer Science", "Commons", "Dan Black Hall", "Engineering", "Education-Classroom", "Engineering & Computer Science", "Eastside Parking Structure", "Golleher Alumni House", "Goodwin Field", "Humanities-Social Sciences", "Kinesiology & Health Science", "Langsdorf Hall", "McCarthy Hall", "Parking & Transportation Office", "Residence Halls", "Housing Office", "Pollak Library", "Corporation Yard - Receiving", "Ruby Gerontology Center", "Student Health & Counseling Center", "Mihaylo Hall", "Student Housing", "Student Rec Center", "Titan Gymnasium", "Titan House", "Titan Stadium", "Titan Student Union", "University Hall", "University Police", "Visual Arts", "Nutwood Parking Structure", "State College Parking Structure", "Visitor Information Center", "A - parking lot", "A-South - parking lot", "G - parking lot", "D - parking lot", "E - parking lot", "I - parking lot", "F - parking lot", "C - parking lot", "S - parking lot", "CPFS - parking lot", "Quad", "Yorba Linda Blvd", "State College Blvd", "Nutwood Ave", "Coportation Dr", "Gymnasium Dr", "Arts Dr", "Titan Ave", "Commonwealth St", "Langsdorf St", "Folino Dr", "Other"]
    @State private var x = false
    @State private var y = true
    //body
    var body: some View {
        //creates tabs
        TabView(){
                //creates form
                Form {
                    //section that gets Category
                    Section {
                        Picker("Select a Category", selection: $Category){
                            ForEach(type, id: \.self){
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    //section that gets Location
                    Section{
                        Picker("Select a Location", selection: $Location){
                            ForEach(place, id: \.self){
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    //section that gets photo
                    Section (header: Text("Image").font(.headline).foregroundColor(Color.blue)){
                        Button(action: {
                            self.isShowPhotoLibrary = true
                        }) {
                            HStack {
                                Image(systemName: "photo")
                                    .font(.system(size: 20))
                                
                                Text("Enter a Photo")
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.horizontal)
                        }
                    }
                    
                    .sheet(isPresented: $isShowPhotoLibrary) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
                    
                    //section that gets Description
                    Section (header: Text("Description").font(.headline).foregroundColor(Color.blue)){
                        TextField(text: $Description, prompt: Text("Enter a Description").foregroundColor(Color.red)) {
                            Text("Password")
                        }
                        .textInputAutocapitalization(.never)
                    }
                    //section that gets Emergency
                    Section (header: Text("Emergency").font(.headline).foregroundColor(Color.blue)){
                        HStack{
                            Text("Yes")
                            Button(action : {
                                Emergency = true
                                if  buttonOn == false{
                                    buttonOn = true
                                    button1 = filled
                                    button2 = empty
                                }
                            }, label : {
                                Image(systemName: button1)
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 18, height: 18)
                            })
                        }
                        HStack{
                            Text("No")
                            Button(action : {
                                Emergency = false
                                if (buttonOn == true || y == true){
                                    buttonOn = false
                                    button1 = empty
                                    button2 = filled
                                    y = false
                                }
                            }, label : {
                                Image(systemName: button2)
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 18, height: 18)
                            })
                        }
                    }

                    //section that gets Resets to Default and Submits
                    Section{
                        HStack {
                            Button(action: {
                                print("Reset to default")
                                reset()
                            }) {
                                Text("Reset to Default")
                            }
                        }
                        HStack {
                            Button(action: {
                                print("Submit");
                                if (Category == "Pick A Category" || Location == "Pick A Location" || (button1 == "empty" && button2 == "empty") || Description == ""){
                                  x = true
                                }
                                else{
                                    //send message
                                    message += "Ticket Data:"
                                    CWID = appState.SavedCWID
                                    message += CWID
                                    message += ":,"
                                    if (Emergency == true){
                                        message += "1"
                                    }
                                    else{
                                        message += "0"
                                    }
                                    message += ":,"
                                    message += Category
                                    message += ":,"
                                    message += Location
                                    message += ":,"
                                    message += Description
                                    //message = "Ticket Data:" + Emergency + ":," + Category" + ":," + Location + ":," + Description
                                    websocket.sendMessage(message)
                                    message = ""
                                    //reset page
                                    reset()
                                    x = false
                                    appState.switchView = .startover
                                }
                            }) {
                                Text("Submit")
                            }
                        }
                        if (x == true){
                            Text("Fill In All Required Fields!")
                        }
                }
            }
            .background(Color.orange)
            .tabItem {
                Label("Form", systemImage: "star")
            }
            .toolbarBackground(Color(red: 245/255, green: 185/255, blue: 113/255), for: .tabBar)
            //tab 2
            Form{
                Section (header: Text("Category:").font(.headline).foregroundColor(Color.blue)){
                    Text("ELECTRICAL")
                }
                    .foregroundColor(Color.red)
                Section (header: Text("Location:").font(.headline).foregroundColor(Color.blue)){
                    Text("Arboretum")
                }
                    .foregroundColor(Color.red)
                Section (header: Text("Image:").font(.headline).foregroundColor(Color.blue)){
                    Image("wires").resizable().scaledToFit()
                }
                    .foregroundColor(Color.green)
                Section (header: Text("Description:").font(.headline).foregroundColor(Color.blue)){
                    Text("Broken wires in the main building")
                }
                    .foregroundColor(Color.red)
                Section (header: Text("Emergency:").font(.headline).foregroundColor(Color.blue)){
                    HStack{
                        Text("Yes")
                        Button(action : {
                            }, label : {
                            Image(systemName: "circle.fill")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                        })
                    }
                    HStack{
                        Text("No")
                        Button(action : {
                            }, label : {
                            Image(systemName: "circle")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                        })
                    }
                }
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
