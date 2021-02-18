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
    @State var sessionData = SessionData.shared
    var user: AuthUser
    
    @State var updateNowPlz : Bool = false
    @State var showAddPrayerView = false

    
    var body: some View {
        
           
                //user's prayers
                NavigationView {
                    ZStack{
                    List {
                        ForEach(sessionData.Prayers) { prayer in
                            
                            if(prayer.createdBy == user.username) {
                                NavigationLink(destination: IndividualPrayerView(prayer: prayer)){
                                    ListRow(prayer: prayer)
                                }
                            }
                           
                        }.onDelete { indices in
                            indices.forEach {
                                // removing from session data will refresh UI
                                let Prayer = self.sessionData.Prayers.remove(at: $0)

                                // asynchronously remove from database
                                AWS_Backend.shared.deletePrayer(Prayer: Prayer)
                            }
                        }
                    }
                    .navigationBarTitle(Text("My Feed"))
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
                                AddPrayerView(sessionData: self.sessionData, user: user)
                            }
                        }
                }
                
                
              
            
            }//end of VStack
            
        
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






// a view to represent a single list item
struct ListRow: View {
    @ObservedObject var prayer : Prayer
    
    var myBadges: [Int] = [1,2,3]
    
    var body: some View {

        return HStack(alignment: .center, spacing: 5.0) {

            // if there is an image, display it on the left
            if (prayer.image != nil) {
                prayer.image!
                .resizable()
                .frame(width: 50, height: 50)
            }

            // the right part is a vertical stack with the title and description
            VStack(alignment: .leading, spacing: 5.0) {
                Text(prayer.name)
                    .bold()
                    .font(.title3)
                
                
               
                HStack {
                    if ((prayer.description) != nil) {
                        if(prayer.description!.count > 50) {
                            Text(prayer.description!.prefix(50) + "...")
                                .font(.body)
                        } else {
                            Text(prayer.description!)
                                .font(.body)
                        }
                       
                    }
                    Spacer()
                    
                    //badges
                    HStack {
                        myBadges.contains(1) ? PrayerBadge(image: Image(systemName: "checkmark.circle")) : nil
                        myBadges.contains(2) ? PrayerBadge(image: Image(systemName: "person.3")) : nil
                        myBadges.contains(3) ? PrayerBadge(image: Image(systemName: "sun.max")) : nil
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
            ListRow(prayer: Prayer(id : UUID().uuidString, name: "Grinders Hunger for Wisdom", description: "That they would seek it like silver"))
            ListRow(prayer: Prayer(id : UUID().uuidString, name: "Will's Stars subscription", description: "Hope he figures it out the information he is looking for in this jounrey"))
        }
        .previewLayout(.fixed(width:400, height:250))
        
    }
    
}


struct PrayerBadge: View {
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

