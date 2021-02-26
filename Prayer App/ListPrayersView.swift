//
//  ListPrayersView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/28/20.
//

import SwiftUI
import Amplify


struct listReadyPrayer: Hashable, Identifiable {
    let id: String
    var title: String
    var description: String?
    var userID: String

    
    init(prayer: Prayer) {
        self.id = prayer.id
        self.title = prayer.title
        self.userID = prayer.userID
        if(prayer.description != nil) {
            self.description = prayer.description
        }
    }
    
}


struct ListPrayersView: View {
    @EnvironmentObject var sessionManager : AuthSessionManager
    @EnvironmentObject var sessionData : SessionData
    var user: AuthUser
    
    @State var updateNowPlz : Bool = false
    @State var showAddPrayerView = false
    
    var listReadyPrayers : [listReadyPrayer]?
    

    
    let listofBadgeLists : [[PrayerBadgeType]] = [
        [.saved, .twoOrMore],
        [.answered, .twoOrMore],
        [.saved, .answered],
        [.saved, .twoOrMore, .answered],
        [.answered],
        [.twoOrMore]
    ]
    
    var body: some View {
        
           
                //user's prayers
                NavigationView {
                    ZStack{
                    List {
                        Section(header: ListHeader()) {
                            ForEach(listReadyPrayers ?? []) { listReadyPrayers in
                                let number = Int.random(in: 0..<6) //tomdo: replace with actauly badge earnings
//                                if(prayer.userID == user.userId) {
//                                    NavigationLink(destination: IndividualPrayerView(prayer: listReadyPrayers)){
                                        ListRow(prayer: listReadyPrayers, myBadges: listofBadgeLists[number])
//                                    }
                                
                               
                            }.onDelete { indices in
                                indices.forEach {
                                    // removing from session data will refresh UI
                                    let Prayer = self.sessionData.prayers.remove(at: $0)

                                    // asynchronously remove from database
                                    //AWS_Backend.shared.deletePrayer(Prayer: Prayer)
                                    
                                    
                                }
                        }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationBarTitle(Text("My Feed" + String(sessionData.prayers.count)))
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
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                                
                            }.sheet(isPresented: $showAddPrayerView) {
                                AddPrayerView(sessionDataPrayers: $sessionData.prayers, user: user, showAddPrayerView: $showAddPrayerView)
                            }
                            
                        }
                }//zstack
                
                
              
            
            }//end of Nav
        
    }//end of view
    
    
}//end of struct

//struct ListPrayersView_Previews: PreviewProvider {
//    let sessionData = SessionData.shared
//
//    static var previews: some View {
//        Text("nope")
//        //ListPrayersView(userData: self.userData)
//    }
//}


struct ListHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
            Text("My Prayers")
        }
    }
}




// a view to represent a single list item
struct ListRow: View {
    var prayer : listReadyPrayer //tomdo: change this type to something good idk
    
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



//struct ListRow_Previews: PreviewProvider {
//
//
//    static var previews: some View {
//
//        List {
//            ListRow(prayer: listReadyPrayer(prayer: Prayer(
//                id : UUID().uuidString,
//                title: "Grinders Hunger for wisdom",
//                description: "That they would seek it like silver",
//                userID: "ID_tom_runnels"
//                ), myBadges: [.saved, .answered]) )
//
//            ListRow(prayer: listReadyPrayer(prayer: Prayer(
//                id : UUID().uuidString,
//                title: "Will's Stars subscription",
//                description: "Hope he figures it out the information he is looking for in this jounrey",
//                userID: "ID_tom_runnels"
//                ), myBadges: [.saved, .answered, .twoOrMore]) )
//
//        }
//        .previewLayout(.fixed(width:400, height:250))
//
//    }
//
//}





struct PrayerBadge: View {
    let type: PrayerBadgeType
    
    var body: some View{
        return ZStack {
//            RoundedRectangle(cornerRadius: 4)
//                .fill(Color.gray)
//                .frame(width: 25, height: 25, alignment:.center)
                
            switch (type) {
            case .saved:
                PrayerBadgeIcon(image: Image(systemName: "checkmark.circle"))
            case .twoOrMore:
                PrayerBadgeIcon(image: Image(systemName: "person.3"))
            case .answered:
                PrayerBadgeIcon(image: Image(systemName: "sun.max"))
            default:
                PrayerBadgeIcon(image: Image(systemName: "xmark.octagon"))
            }

        }
    }

}

enum PrayerBadgeType  {
    case saved
    case twoOrMore
    case answered
    case inGroup
    case inPrivate
    case inBody
    case inFriends
}


struct PrayerBadgeIcon: View {
    let image: Image
    
    
    var body: some View{
        return ZStack {
//            RoundedRectangle(cornerRadius: 4)
//                .fill(Color.gray)
//                .frame(width: 25, height: 25, alignment:.center)
                
            image
                .colorMultiply(.yellow)

        }
    }

}


