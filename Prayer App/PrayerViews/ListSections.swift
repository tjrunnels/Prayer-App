//
//  ListSections.swift
//  Prayer App
//
//  Created by tomrunnels on 3/1/21.
//

import SwiftUI
import Amplify


struct MyPrayersSection: View {
    
    @Binding var prayers: [Prayer]
    var currentUserID: String
    
        
    
    let listofBadgeLists : [[PrayerBadgeType]] = [
        [.saved, .twoOrMore],
        [.answered, .twoOrMore],
        [.saved, .answered],
        [.saved, .twoOrMore, .answered],
        [.answered],
        [.twoOrMore]
    ]
    
    var body: some View{
        
                    
            Section(header: HStack {
                Image(systemName: "person.fill")
                Text("My Prayers")
            }
            ) {
                
                ForEach(prayers) { prayer in
                    let number = Int.random(in: 0..<6) //tomdo: replace with actauly badge earnings
                       
                        
                        //WHAT MAKES THIS UNIQUE
                        if(prayer.userID == currentUserID) {
                            NavigationLink(destination: IndividualPrayerView(prayer: prayer)){
                                ListRow(prayer: prayer, myBadges: listofBadgeLists[number])
                            }
                            
                        }
                
                }.onDelete { indices in
                    indices.forEach {
                        // removing from session data will refresh UI
                        let Prayer = prayers.remove(at: $0)

                        // asynchronously remove from database
                        //AWS_Backend.shared.deletePrayer(Prayer: Prayer)
                        Amplify.DataStore.delete(Prayer) {
                            result in
                            switch(result) {
                            case .success:
                                print("Deleted item: \(Prayer.id)")
                            case .failure(let error):
                                print("Could not update data in Datastore: \(error)")
                            }
                        }

                    }
                }
            }
            //.listStyle(InsetGroupedListStyle())  //buggy but cool blue list title??

    }
    
}


struct OthersPrayersSection: View {
    
    @Binding var prayers: [Prayer]
    var currentUserID: String
    
    
    let listofBadgeLists : [[PrayerBadgeType]] = [
        [.saved, .twoOrMore],
        [.answered, .twoOrMore],
        [.saved, .answered],
        [.saved, .twoOrMore, .answered],
        [.answered],
        [.twoOrMore]
    ]
    
    var body: some View{
        Section(header: HStack {
            Image(systemName: "person.2.fill")
            Text("Friends' Prayers")
        }
        ) {
            
            ForEach(prayers) { prayer in
                let number = Int.random(in: 0..<6) //tomdo: replace with actauly badge earnings
                   
                    
                    //WHAT MAKES THIS UNIQUE
                    if(prayer.userID != currentUserID && prayer.prayergroupID != nil) {
                        NavigationLink(destination: IndividualPrayerView(prayer: prayer)){
                            ListRow(prayer: prayer, myBadges: listofBadgeLists[number])
                        }
                    }

            }.onDelete { indices in
                indices.forEach {
                    // removing from session data will refresh UI
                    let Prayer = prayers.remove(at: $0)

                    // asynchronously remove from database
                    //AWS_Backend.shared.deletePrayer(Prayer: Prayer)
                    Amplify.DataStore.delete(Prayer) {
                        result in
                        switch(result) {
                        case .success:
                            print("Deleted item: \(Prayer.id)")
                        case .failure(let error):
                            print("Could not update data in Datastore: \(error)")
                        }
                    }
                   
                }
            }
        }
        //.listStyle(InsetGroupedListStyle())  //buggy but cool blue list title??

    }
}




struct GroupPrayerSection: View {
    
    @Binding var prayers: [Prayer]
    var pGroup: PrayerGroup
    
    
    let listofBadgeLists : [[PrayerBadgeType]] = [
        [.saved, .twoOrMore],
        [.answered, .twoOrMore],
        [.saved, .answered],
        [.saved, .twoOrMore, .answered],
        [.answered],
        [.twoOrMore]
    ]
    
//    init(prayers: Binding<[Prayer]>, group: PrayerGroup) {
//        self._prayers = prayers
//        self.pGroup = group
//
//        print("beep")
//        loadPrayerListByGroup(groupID: pGroup.id)
//
//    }
//
//
    var body: some View{
        Section(header: HStack {
            Image(systemName: "person.3.fill")
            Text("Group: " + (pGroup.name ?? pGroup.id))
        }
        ) {
            
            ForEach(prayers) { prayer in
                let number = Int.random(in: 0..<6) //tomdo: replace with actauly badge earnings
                   
                    // MARK: -
                    //          WHAT MAKES THIS UNIQUE
                if(prayer.prayergroupID == pGroup.id) {
                        NavigationLink(destination: IndividualPrayerView(prayer: prayer)){
                            ListRow(prayer: prayer, myBadges: listofBadgeLists[number])
                        }
                    }

            }
        }
    }
}
