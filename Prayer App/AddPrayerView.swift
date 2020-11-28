//
//  AddPrayerView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/28/20.
//

import SwiftUI
import Amplify

struct AddPrayerView: View {
    var sessionData: SessionData
    var user : AuthUser

    @State var name : String        = "New Prayer"
    @State var description : String = "This is a new Prayer"
    
    @State var image : UIImage?
    @State var showCaptureImageView = false
    
    
    var body: some View {
        Form {

            Section(header: Text("TEXT")) {
                TextField("Name", text: $name)
                TextField("Name", text: $description)
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

                    let prayer = Prayer(id : UUID().uuidString,
                                    name: self.$name.wrappedValue,
                                    description: self.$description.wrappedValue,
                                    createdBy: self.user.username
                                    
                                    
                    )
                    print("testing with: \(self.user.username)")

                    if let i = self.image  {
                        prayer.imageName = UUID().uuidString
                        prayer.image = Image(uiImage: i)

                        // asynchronously store the image (and assume it will work)
                        AWS_Backend.shared.storeImage(name: prayer.imageName!, image: (i.pngData())!)
                    }

                    // asynchronously store the Prayer (and assume it will succeed)
                    AWS_Backend.shared.createPrayer(Prayer: prayer)

                    // add the new Prayer in our sessionData, this will refresh UI
                    withAnimation { self.sessionData.Prayers.append(prayer) }
                }) {
                    Text("Create this Prayer")
                }
            }



        }
    }
}
