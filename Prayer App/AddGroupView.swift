//
//  AddPrayerView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/28/20.
//

import SwiftUI
import Amplify

struct AddGroupView: View {

    @Binding var sessionDataPrayerGroups : [PrayerGroup]
    var user : AuthUser
    @Binding var showAddGroupView: Bool

    @State var title : String           = "My New Group"
        

    
    var body: some View {
        Form {

            Section(header: Text("TEXT")) {
                TextField("Title", text: $title)


            }
            
            
            Section {
                Button(action: {

                    let toSavePrayerGroup = PrayerGroup(
                        name: $title.wrappedValue
                    )
                    print("Save Prayer pressed for: \(toSavePrayerGroup.name ?? "no title given..?")")
                    
    
                    Amplify.DataStore.save(toSavePrayerGroup) { result in
                        switch(result) {
                        case .success(let savedItem):
                            print("Saved item: \(savedItem.id)")
                        case .failure(let error):
                            print("Could not save item to DataStore: \(error)")
                        }
                    }

                    // add the new Prayer in our sessionData, this will refresh UI
                    self.sessionDataPrayerGroups.append(toSavePrayerGroup)
                    showAddGroupView = false
                    
                }) {
                    Text("Create this Prayer")
                }
            }



        }
    }
}



//struct AddGroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddGroupView(sessionDataPrayerGroups: Binding<[PrayerGroup]>, user: AuthUser, showAddGroupView: Binding<Bool>)
//    }
//}
