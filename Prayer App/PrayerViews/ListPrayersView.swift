//
//  ListPrayersView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/28/20.
//

import SwiftUI
import Amplify


struct ListPrayersView: View {
    @EnvironmentObject var sessionManager : AuthSessionManager
    @EnvironmentObject var sessionData : SessionData
    var user: AuthUser
    
    @State var updateNowPlz : Bool = false
    @State var showAddPrayerView = false
    
    @State var groupIDsToShow : [String] = ["CF4D76DE-924E-4002-8B3C-2200EAFEA123"]
    
    
    
    let listofBadgeLists : [[PrayerBadgeType]] = [
        [.saved, .twoOrMore],
        [.answered, .twoOrMore],
        [.saved, .answered],
        [.saved, .twoOrMore, .answered],
        [.answered],
        [.twoOrMore]
    ]
    
    
    
    func loadMyPrayerList () {
        Amplify.DataStore.query(
                Prayer.self,
                where: Prayer.keys.userID == self.user.userId
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
        
           
                //user's prayers
                NavigationView {
                    ZStack{
                    List {
                        MyPrayersSection(prayers: $sessionData.prayers, currentUserID: user.userId)
                        OthersPrayersSection(prayers: $sessionData.prayers, currentUserID: user.userId)
                        ForEach(groupIDsToShow, id: \.self) { groupid in
                            GroupPrayerSection(prayers: $sessionData.prayers, groupID: groupid)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationBarTitle(Text("Feed: " + user.userId))
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.showAddPrayerView.toggle()
                                    print("button pressed")
                                }, label: {
                                    Text("+")
                                    .font(.system(.largeTitle))
                                    .frame(width: 57, height: 50)
                                    .foregroundColor(Color.black)
                                    .padding(.bottom, 7)
                                })
                                .background(Color("Element"))
                                .cornerRadius(38.5)
                                .padding()
                                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                                
                            }.sheet(isPresented: $showAddPrayerView) {
                                AddPrayerView(sessionDataPrayers: $sessionData.prayers, user: user, showAddPrayerView: $showAddPrayerView)
                            }
                            
                        }
                }//zstack
            
            }//end of NavigationView
                .onAppear(perform: loadMyPrayerList)
    }//end of view
    
    
}//end of struct



// a view to represent a single list item
struct ListRow: View {
    var prayer : Prayer
    
    var myBadges: [PrayerBadgeType]
    
    var body: some View {

        return HStack(alignment: .center, spacing: 5.0) {

            // if there is an image, display it on the left
//            if (prayer.image != nil) {
//                prayer.image!
//                .resizable()
//                .frame(width: 50, height: 50)
//            }

            // the right part is a vertical stack with the title and description
            VStack(alignment: .leading, spacing: 5.0) {
                Text(prayer.title)
                    .bold()
                    .font(.title3)
                
                
               
                VStack(alignment: .leading) {
                    if ((prayer.description) != nil) {
                        if(prayer.description!.count > 50) {
                            Text(prayer.description!.prefix(50) + "...")
                                .font(.body)
                        } else {
                            Text(prayer.description!)
                                .font(.body)
                        }
                        Text("$ " + prayer.id)
                            .font(.caption2)
                       
                    }
                    
                    
                    Spacer(minLength: 15)
                    //badges
                    HStack {
                        ForEach(myBadges, id: \.self) { thisType in
                            PrayerBadge(type: thisType)
                        }
                    }

                    
                }

                
//                if ((prayer.createdBy) != nil ) {
//                    Text("- \(prayer.createdBy!)")
//                        .foregroundColor(Color.gray)
//                }
//                else {
//                    Text("- Anonymous")
//                        .foregroundColor(Color.gray)
//                }
                
            }
        }//end of return
        .padding([.top, .bottom], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}



struct ListRow_Previews: PreviewProvider {


    static var previews: some View {
        List {
            MyPrayersSection(prayers: .constant([
                    Prayer(
                        id : UUID().uuidString,
                        title: "Grinders Hunger for wisdom",
                        description: "That they would seek it like silver",
                        userID: "ID_tom_runnels"
                        ),
                    Prayer(
                        id : UUID().uuidString,
                        title: "Lunch at Papichulo",
                        description: "It would taste good",
                        userID: "ID_tom_runnels"
                        ),
                    Prayer(
                        id : UUID().uuidString,
                        title: "Like literaccy",
                        description: "cause i can't spell for nothin",
                        userID: "ID_tom_runnels"
                        )
                ]), currentUserID: "ID_tom_runnels"
            )
        }
        .listStyle(InsetGroupedListStyle())
        .previewLayout(.fixed(width:400, height:700))
    }

}




