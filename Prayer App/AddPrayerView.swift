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
    var user : AuthUser
    @Binding var showAddPrayerView: Bool

    @State var title : String        = "New Prayer"
    @State var description : String = "This is a new Prayer"
    
    @State var image : UIImage?
    @State var showCaptureImageView = false
    

    
    var body: some View {
        Form {

            Section(header: Text("TEXT")) {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }

            Section(header: Text("PICTURE")) {
                VStack {
                    Button(action: {
                        self.showCaptureImageView.toggle()
                    }) {
                        Text("Choose photo")
                    }.sheet(isPresented: $showCaptureImageView) {
                        CaptureImageView(isShown: self.$showCaptureImageView, image: self.$image)
                    }
                    if (image != nil ) {
                        HStack {
                            Spacer()
                            Image(uiImage: image!)
                                .resizable()
                                .frame(width: 250, height: 200)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                            Spacer()
                        }
                    }
                }
            }

            Section {
                Button(action: {

                    var prayer = Prayer(id : UUID().uuidString,
                                    title: self.$title.wrappedValue,
                                    description: self.$description.wrappedValue,
                                    userID: self.user.userId
                                    
                                    
                    )
                    print("Save Prayer pressed as: \(self.user.username)")
                    
                    
                    //tomdo: this doesn't make sense but whatever
                    if let i = self.image  {
                        prayer.image = UUID().uuidString
                        //prayer.image = Image(uiImage: i)
                    }
                    
                    
                    //datastoredo: doesn't seem like its syncing my prayers up with AWS perfectly... is it because i'm telling them the userid?  Should i instead tell them the User.id that i grabbed?  isn't it the same?
                    let item = Prayer(
                        title: self.title,
                        description: self.description,
                        prayergroupID: "null", //for some reason you have to have prayergroupID included important!
                        userID: user.userId
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
                    Text("Create this Prayer")
                }
            }



        }
    }
}
