//
//  AddPrayerView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/28/20.
//

import SwiftUI
import Amplify

//  AddGroupView(sessionDataPrayerGroups: $sessionData.prayerGroups, user: user, showAddGroupView: $showAddGroupView)


struct AddGroupView: View {

    @Binding var sessionDataPrayerGroups : [PrayerGroup]
    var user : User
    @Binding var showAddGroupView: Bool

    @State var title : String           = ""
        

    
    var body: some View {
        
        
        NavigationView {
                Form {
                    

                    Section(header: Text("details")) {
                        CustomTextField(placeholder: Text("title").foregroundColor(.gray), text: $title)
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
                            Text("Create this Group")
                        }
                    }
                    

                } //form
                .navigationBarTitle(Text("Create a New Group"))
                
                
                
        } //navigationView

    }
}



//struct AddGroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddGroupView(sessionDataPrayerGroups: Binding<[PrayerGroup]>, user: AuthUser, showAddGroupView: Binding<Bool>)
//    }
//}





struct JoinGroupView: View {

    @Binding var sessionDataPrayerGroups : [PrayerGroup]
    var sessionDataUser : User
    @Binding var showJoinGroupView: Bool
    @Binding var myPrayerGroupUsers: [PrayerGroupUser]

    
    var body: some View {
       
        
        NavigationView {
            Form {
                    ForEach(sessionDataPrayerGroups) { group in
                        Button(action: {

                            print("Join Group pressed for: \(group.name ?? group.id)")
                            
                            let pGroupUser = PrayerGroupUser(prayergroup: group, user: sessionDataUser)
            
                            Amplify.DataStore.save(pGroupUser) { result in
                                switch(result) {
                                case .success(let savedItem):
                                    print("Saved item: \(savedItem.id)")
                                case .failure(let error):
                                    print("Could not save item to DataStore: \(error)")
                                }
                            }

                            // add the new Prayer in our sessionData, this will refresh UI
                            self.myPrayerGroupUsers.append(pGroupUser)
                            showJoinGroupView = false
                            
                        }) {
                            Text(group.name ?? group.id)
                        }
                    }

            }.listStyle(InsetGroupedListStyle())
            .navigationTitle(Text("Join which group?"))
            
        }
                
    }
}




//  AddGroupView(sessionDataPrayerGroups: $sessionData.prayerGroups, user: user, showAddGroupView: $showAddGroupView)

struct AddGroupView_Previews: PreviewProvider {
    @State static var pray: [PrayerGroup] = []
    @State static var val = true


    static var previews: some View {
        AddGroupView(sessionDataPrayerGroups: $pray, user: User(id: "ID_user123"), showAddGroupView: $val)
       // Text("Hello world")
    }
}


struct JoinAGroupView_Previews: PreviewProvider {
    @State static var pray: [PrayerGroup] = [
        PrayerGroup(id: "id1", name: "Rivendell"),
        PrayerGroup(id: "id1", name: "Gondor"),
        PrayerGroup(id: "id1", name: "Rohan"),
        PrayerGroup(id: "id1", name: "Mordor"),
        PrayerGroup(id: "id1", name: "Mirkwood"),
    ]
    @State static var prayUser: [PrayerGroupUser] = []
    @State static var val = true


    static var previews: some View {
        JoinGroupView(sessionDataPrayerGroups: $pray, sessionDataUser: User(id: "ID_user123"), showJoinGroupView: $val, myPrayerGroupUsers: $prayUser)
        // Text("Hello world")
    }
}
