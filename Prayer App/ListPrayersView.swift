//
//  ListPrayersView.swift
//  Prayer App
//
//  Created by tomrunnels on 11/28/20.
//

import SwiftUI

struct ListPrayersView: View {
    @EnvironmentObject var sessionManager : AuthSessionManager

    var sessionData: SessionData
    
    
    var body: some View {
        
        ZStack {
                NavigationView {
                    List {
                        ForEach(sessionData.Prayers) { Prayer in
                            ListRow(Prayer: Prayer)
                        }.onDelete { indices in
                            indices.forEach {
                                // removing from session data will refresh UI
                                let Prayer = self.sessionData.Prayers.remove(at: $0)

                                // asynchronously remove from database
                                AWS_Backend.shared.deletePrayer(Prayer: Prayer)
                            }
                        }
                    }
                    .navigationBarTitle(Text("Prayers"))
                   
                }
        }
        
        
    }
}

struct ListPrayersView_Previews: PreviewProvider {
    let sessionData = SessionData.shared

    static var previews: some View {
        Text("nope")
        //ListPrayersView(userData: self.userData)
    }
}






// a view to represent a single list item
struct ListRow: View {
    @ObservedObject var Prayer : Prayer
    var body: some View {

        return HStack(alignment: .center, spacing: 5.0) {

            // if there is an image, display it on the left
            if (Prayer.image != nil) {
                Prayer.image!
                .resizable()
                .frame(width: 50, height: 50)
            }

            // the right part is a vertical stack with the title and description
            VStack(alignment: .leading, spacing: 5.0) {
                Text(Prayer.name)
                .bold()

                if ((Prayer.description) != nil) {
                    Text(Prayer.description!)
                }
                
                if ((Prayer.createdBy) != nil ) {
                    Text("- \(Prayer.createdBy!)")
                        .foregroundColor(Color.gray)
                }
                else {
                    Text("- Anonymous")
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}
