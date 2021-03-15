//
//  GroupsView.swift
//  Prayer App
//
//  Created by tomrunnels on 3/4/21.
//

//
//  ListPrayersView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/28/20.
//

import SwiftUI
import Amplify


struct GroupsView: View {
    @EnvironmentObject var sessionManager : AuthSessionManager
    @EnvironmentObject var sessionData : SessionData
    var user: AuthUser
    
    @State var updateNowPlz : Bool = false
    @State var showAddGroupView = false
    @State var showJoinGroupView = false
    @State var myPrayerGroupUsers: [PrayerGroupUser] = []
    
    //@State var groupIDsToShow : [String] = ["CF4D76DE-924E-4002-8B3C-2200EAFEA123"]
    
    
    func loadGroups () {
        Amplify.DataStore.query(
                PrayerGroup.self
            ) { result in
            do {
                let thisGroups = try result.get()
                print("PrayerGroup datastore query results: ")
                print(thisGroups)
                DispatchQueue.main.async {
                    sessionData.prayerGroups = thisGroups
                }
            } catch {
                print(error)
            }
        }
    }
    
    
    
    func loadPrayerListByGroup (groupID: String) {
        Amplify.DataStore.query(
                Prayer.self,
                where: Prayer.keys.prayergroupID == groupID
            ) { result in
            do {
                let thisPrayers = try result.get()
                print("loadPrayerList query results: ")
                print(thisPrayers)
                DispatchQueue.main.async {
                    sessionData.prayers = thisPrayers
                }
            } catch {
                print(error)
            }
        }
    }
    
   

    
    
    
    
    
    
    var body: some View {
        
            NavigationView {

                ZStack {
                    
                    List {
                        MyGroupSection(thisUsers_PrayerGroupUsers: Array(sessionData.currentUser!.prayergroups!), allPrayers: sessionData.prayers)
                        GroupSection(prayerGroups: sessionData.prayerGroups, allPrayers: sessionData.prayers)
                    }
                    .navigationBarTitle(Text("Groups"))
                    .listStyle(InsetGroupedListStyle())



                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            
                            //join button
                            Button(action: {
                                self.showJoinGroupView.toggle()
                                print("showJoin button pressed")
                            }, label: {
                                Image(systemName: "rectangle.stack.badge.plus")
                                .frame(width: 57, height: 50)
                                .foregroundColor(Color.black)
                                .padding(.bottom, 7)
                            })
                            .background(Color("Element"))
                            .cornerRadius(38.5)
                            .padding([.top,.bottom, .trailing])
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                            .sheet(isPresented: $showJoinGroupView) {
                                JoinGroupView(sessionDataPrayerGroups: $sessionData.prayerGroups, sessionDataUser: sessionData.currentUser!, showJoinGroupView: $showJoinGroupView, myPrayerGroupUsers: $myPrayerGroupUsers)
                            }
                            
                            
                            //add button
                            Button(action: {
                                self.showAddGroupView.toggle()
                                print("showAdd button pressed")
                            }, label: {
                                Text("+")
                                .font(.system(.largeTitle))
                                .frame(width: 57, height: 50)
                                .foregroundColor(Color.black)
                                .padding(.bottom, 7)
                            })
                            .background(Color("Element"))
                            .cornerRadius(38.5)
                            .padding([.top,.bottom, .trailing])
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                            .sheet(isPresented: $showAddGroupView) {
                                AddGroupView(sessionDataPrayerGroups: $sessionData.prayerGroups, user: user, showAddGroupView: $showAddGroupView)
                            }
                            
                        }
                        
                    }//add button vstack
                    
                    
                    
                    
                    
                    
                }//zstack
            
            }//end of NavigationView
                .onAppear(perform: loadGroups)
            
        
    }//end of view
    
    
}//end of struct


struct GroupSection: View {
    
    var prayerGroups: [PrayerGroup]
    var allPrayers: [Prayer]
    
    var body: some View {


            Section(header: HStack {
                Image(systemName: "person.icloud.fill")
                Text("All Groups")
            }
            ) {
                
                ForEach(prayerGroups) { group in
                    VStack {
                        NavigationLink(destination: IndividualGroupView(thisGroups_Users: Array(group.PrayerGroupUsers!), thisGroup_Prayers: allPrayers.filter { $0.prayergroupID == group.id }))
                        {
                            GroupRow(id: group.id, name: group.name)
                        }
                    }
                
                }
            }
        
        //.listStyle(InsetGroupedListStyle())  //buggy but cool blue list title??
    }
    
}

struct MyGroupSection: View {
    
    var prayerGroups: [PrayerGroup]
    var allPrayers: [Prayer]
    
    init(thisUsers_PrayerGroupUsers: [PrayerGroupUser], allPrayers: [Prayer]) {
        prayerGroups = thisUsers_PrayerGroupUsers.map {$0.prayergroup}  //array.map can be very useful in this whole groupuser/group situation.  basically map {$0.prayergroup} says "this array, but i just want the prayergroups variables from the entries
        self.allPrayers = allPrayers
    }
    
    var body: some View {

            Section(header: HStack {
                Image(systemName: "rectangle.stack.person.crop")
                Text("My Groups")
                Button(action: {print("he pressed it!")}, label: {
                    Text("see all")
                })
            }
            ) {

                ForEach(prayerGroups) { group in
                    VStack {
                        NavigationLink(destination: IndividualGroupView(thisGroups_Users: Array(group.PrayerGroupUsers!), thisGroup_Prayers: allPrayers.filter { $0.prayergroupID == group.id }))
                        {
                            GroupRow(id: group.id, name: group.name)
                        }
                    }
                
                }
              
            }
        
            //.listStyle(InsetGroupedListStyle())  //buggy but cool blue list title??

        //.listStyle(InsetGroupedListStyle()) //note:  in putting this here instead of in the List in the parent View, it makes it blue and retractable ?  kinda cool i guess
    
    }
}


struct IndividualGroupView: View {
    var thisGroups_Users : [PrayerGroupUser]
    var thisGroup_Prayers: [Prayer]
    
    var body: some View {
        List {
            Section(header: HStack {
                Image(systemName: "person.fill")
                Text("Group Members")
            }
            ) {
                ForEach(thisGroups_Users) { groupUser in
                    Text(groupUser.user.username ?? groupUser.user.id)
                }
            }
            Section(header: HStack {
                Image(systemName: "mail")
                Text("Prayers")
            }
            ) {
                ForEach(thisGroup_Prayers) { prayer in
                    NavigationLink(destination: IndividualPrayerView(prayer: prayer)) {
                        ListRow(prayer: prayer, myBadges: [.answered,.inPrivate])
                    }
                }
            }
        }.listStyle(InsetGroupedListStyle())

    }
}




struct GroupsSectionView_Previews: PreviewProvider {
     
    static var previews: some View {
        GroupSection(prayerGroups:
            [
                PrayerGroup(id: "CF4D76DE-924E-4002-8B3C-2200EAFEA123", name: "Gondor"),
                PrayerGroup(id: "5186SASD-RR44-EFFE-7841-897641213684", name: "Rohan"),
                PrayerGroup(id: "HREEWCEE-EW48-66RS-156R-5431WEW12165", name: "The Shire"),
                PrayerGroup(id: "486ESFEW-WEF8-48AZ-X48Z-VBRGHWS48689", name: "Prancing Pony")
            ], allPrayers: [
                Prayer(title: "title1", userID: "ID_title_1"),
                Prayer(title: "title2", userID: "ID_title_2"),
                Prayer(title: "title3", userID: "ID_title_3")

            ]
                    
        )
        .previewLayout(.fixed(width: 390, height: 500))
    }
    
}






struct GroupRow: View {
    
    var id: String
    var name: String?
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(name ?? "").font(.title3).padding(.top, 15)
            Text("$ " + id).font(.caption2).padding(.bottom, 15)
        }
    }
    
    
}

struct GroupsRowView_Previews: PreviewProvider {
    

    static var previews: some View {
        GroupRow(id: "CF4D76DE-924E-4002-8B3C-2200EAFEA123", name: "Rohan")
            .previewLayout(.fixed(width: 350, height: 100))
    }
    
}





//
//
//struct GroupsView_Previews: PreviewProvider {
//
//
//    var body: some View {
//        HStack {
//            Image(systemName: "person.fill")
//            Text("My Groups")
//        }
//    }
//}
//
//
