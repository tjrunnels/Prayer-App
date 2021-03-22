//
//  AddPrayerView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/28/20.
//

import SwiftUI
import Amplify

struct AddPrayerView: View {
    
    @Binding var sessionDataPrayers: [Prayer]
    var user : User
    @Binding var showAddPrayerView: Bool

    @State var title : String           = ""
    @State var description : String     = ""
    
    @State var image : UIImage?
    @State var group : String   = ""
    @State var showCaptureImageView = false
    
    @State var groupName: String = ""
    
    
    var body: some View {
        
                                
        NavigationView {
            Form {

                
                    Section(header: Text("Content")) {
                            
                        CustomTextField(placeholder: Text("title").foregroundColor(.gray), text: $title)
                        CustomTextField(placeholder: Text("description").foregroundColor(.gray), text: $description).padding([.top,.bottom], 20)
                        
                          //  TextField("Title", text: $title)
                          //  TextField("Description", text: $description).padding([.top,.bottom], 20)
                    }
                
                    Section(header: Text("Group sharing")) {
                        NavigationLink(destination: GroupPickView(groupsToShow: user.pGroupsJoined(), groupIDToSet: $group)) {
                            if(groupName == "") {
                                Text("Personal (no group)").foregroundColor(.black)
                            } else {
                                Text(groupName)
                            }
                        }

                    }
                    
        //            Section(header: Text("PICTURE")) {
        //                VStack {
        //                    Button(action: {
        //                        self.showCaptureImageView.toggle()
        //                    }) {
        //                        Text("Choose photo")
        //                    }.sheet(isPresented: $showCaptureImageView) {
        //                        CaptureImageView(isShown: self.$showCaptureImageView, image: self.$image)
        //                    }
        //                    if (image != nil ) {
        //                        HStack {
        //                            Spacer()
        //                            Image(uiImage: image!)
        //                                .resizable()
        //                                .frame(width: 250, height: 200)
        //                                .clipShape(Circle())
        //                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
        //                                .shadow(radius: 10)
        //                            Spacer()
        //                        }
        //                    }
        //                }
        //            }
                    
                    

                    Section {
                        Button(action: {

                            let prayer = Prayer(id : UUID().uuidString,
                                            title: self.$title.wrappedValue,
                                            description: self.$description.wrappedValue,
                                            prayergroupID: self.$group.wrappedValue,
                                            userID: self.user.id
                                            
                                            
                            )
                            print("Save Prayer pressed as: \(self.user.username ?? "")")
                            
                            
        //                    //tomdo: this doesn't make sense but whatever
        //                    if let i = self.image  {
        //                        prayer.image = UUID().uuidString
        //                        //prayer.image = Image(uiImage: i)
        //                    }
        //
                            
                            //datastoredo: doesn't seem like its syncing my prayers up with AWS perfectly... is it because i'm telling them the userid?  Should i instead tell them the User.id that i grabbed?  isn't it the same?
                            let item = Prayer(
                                title: self.title,
                                description: self.description,
                                prayergroupID: self.group, //for some reason you have to have prayergroupID included !-important-!
                                userID: user.id
                                )
                            Amplify.DataStore.save(item) { result in
                                switch(result) {
                                case .success(let savedItem):
                                    print("Saved item: \(savedItem.id)")
                                case .failure(let error):
                                    print("Could not save item to DataStore: \(error)")
                                }
                            }

                            // add the new Prayer in our sessionData, this will refresh UI
                            self.sessionDataPrayers.append(prayer)
                            showAddPrayerView = false
                            
                        }) {
                            Text("Save Prayer")
                        }
                    }



                } //end of form
                .navigationBarTitle(Text("Add a Prayer"))
                .onAppear {
                    if(group != "") {
                        let array = user.pGroupsJoined()
                        let item = array.filter {$0.id == group }
                        if(item.count > 0) { groupName = item[0].name ?? "" }
                    
                    }
                    else {
                        groupName = ""
                    }
                }

        } //nav



        } //body
    
    ///returns a boolen if the string is valid
    func verifyGroup(groupid: String) -> Bool {
        if(groupid != "" && groupid != " ") {
            return true
        }
        else {
            return false
        }

    }
}



struct GroupPickView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
 
    var groupsToShow: [PrayerGroup]
    @Binding var groupIDToSet: String
    
    var body: some View {
            List {
                ForEach(groupsToShow) { pGroup in
                    Button(action: {
                        groupIDToSet = pGroup.id
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text(pGroup.name ?? pGroup.id)
                    })
                }
                Button(action: {
                    groupIDToSet = ""
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Personal (no group)").foregroundColor(.black)
                })

                
            }
            .navigationBarTitle(Text("Choose a Group"))
            .listStyle(InsetGroupedListStyle())

        
    }
}




struct AddPrayerView_Previews: PreviewProvider {
    @State static var pray: [Prayer] = [Prayer(title: "hey", userID: "heyID")]
    @State static var val = true
    private struct DummyUser: AuthUser {
        let userId: String = "1"
        let username: String = "dummyUser"
    }

    static var previews: some View {
        AddPrayerView(sessionDataPrayers: $pray, user: User(id: "ID_user123"), showAddPrayerView: $val)
    }
}
