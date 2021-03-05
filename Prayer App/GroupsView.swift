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
    @State var showAddPrayerView = false
    
    @State var groupIDsToShow : [String] = ["CF4D76DE-924E-4002-8B3C-2200EAFEA123"]
    
    
    func loadGroups () {
        Amplify.DataStore.query(
                PrayerGroup.self
            ) { result in
            do {
                let thisGroups = try result.get()
                print("prayerGroups datastore query results: ")
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
                print("prayers datastore query results: ")
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

                    List {
                        Section(header: HStack {
                            Image(systemName: "person.icloud.fill")
                            Text("All Groups")
                        }
                        ) {
                            ForEach(sessionData.prayerGroups) { group in
                                VStack {
                                    Text(group.name ?? "").padding(.top, 15)
                                    Text(group.id).font(.caption).padding(.bottom, 15)
                                }
                            
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
            
            }//end of NavigationView
                .onAppear(perform: loadGroups)
        
    }//end of view
    
    
}//end of struct


struct GroupSection: View {
    
    var prayerGroups: [PrayerGroup]
    
    var body: some View {

        List {
            Section(header: HStack {
                Image(systemName: "person.icloud.fill")
                Text("All Groups")
            }
            ) {
                
                ForEach(prayerGroups) { group in
                    VStack {
                        GroupRow(id: group.id, name: group.name)
                    }
                
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
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
