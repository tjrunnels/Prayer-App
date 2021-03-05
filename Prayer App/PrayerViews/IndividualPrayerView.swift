//
//  IndividualPrayerView.swift
//  Prayer App
//
//  Created by tomrunnels on 2/18/21.
//

import SwiftUI

struct IndividualPrayerView: View {
    var prayer: Prayer

    var myBadges: [Int] = [1,2,3]
    
    

    var body: some View {

            

        VStack(alignment: .leading) {

        //Title
            Group {
                Text("Prayer")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding([.leading], 10)
                    .padding(.bottom, 1)
                Text(prayer.title)
                    .font(.title)
                    .bold()
                    .padding([.leading], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }


        //Description
            Group {
                Text("Description")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding([.top, .leading], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 1)
                Text(prayer.description ?? "")
                    .font(.body)
                    .padding([.leading], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }



        //Author
            Group {
                Text("Author")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding([.top, .leading], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 1)
                Text("@" + prayer.userID)
                    .font(.body)
                    .padding([.leading], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.gray)

                Divider()
            }
            
        //Group
            Group {
                Text("Group")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding([.top, .leading], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 1)
                Text(prayer.prayergroupID ?? "Not in a group")
                    .font(.body)
                    .padding([.leading], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)

                Divider()
            }


        //Badges
            Group {
                Text("Badges")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.black)
                    .padding([.leading], 10)
            //badges
                Group {
                    prayer.badges?.count == 0 ? Text("This prayer has earned no badges").font(.caption) : Text("")
                }.padding(.leading, 10  )
                
                VStack {
                    prayer.badges?.contains("saved") ?? false ? DetailedPrayerBadge(image: Image(systemName: "checkmark.circle"), earned: true, thisTitle: "Saved", thisDescription: "this prayer is in the cloud") : nil
                    prayer.badges?.contains("2 or more") ?? false ? DetailedPrayerBadge(image: Image(systemName: "person.3"), earned: true, thisTitle: "2 or More", thisDescription: "More than 2 differnt people have prayed for this") : nil
                    prayer.badges?.contains("answered") ?? false ? DetailedPrayerBadge(image: Image(systemName: "sun.max"), earned: true, thisTitle: "Answered", thisDescription: "Prayer has been answered") : nil
                }
                Divider().padding(.top, 10)
            }

            Spacer()

        }

        .multilineTextAlignment(.leading)
        .padding(.top, 0)
        .toolbar(content: {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "star")
                })
                Spacer()
                Button("Answer") {}
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "trash")
                })
            }
        })


    }


} //end of struct





struct IndividualPrayerView_Previews: PreviewProvider {


    static var previews: some View {

        NavigationView {
            IndividualPrayerView(prayer: Prayer(title: "testTitle", description: "this is the test description of my prayer request and i'm sticking with it no matter what!", badges: ["saved", "answered"], userID: "testID123"))
            
        }

    }
}





struct DetailedPrayerBadge: View {
    let image: Image
    let earned: Bool
    let thisTitle: String
    let thisDescription: String


    var body: some View{
        return HStack {
            ZStack {
                earned == true ? RoundedRectangle(cornerRadius: 6)
                    .fill(Color("BadgeEarned"))
                    .frame(width: 50, height: 30, alignment:.center) : RoundedRectangle(cornerRadius: 6)
                    .fill(Color("BadgeUnearned"))
                    .frame(width: 50, height: 30, alignment:.center)

                image
                    .colorMultiply(.yellow)
            }


            earned == true ? Text(thisTitle +  ": " + thisDescription).foregroundColor(Color(.black)) : Text(thisTitle +  ": " + thisDescription).foregroundColor(Color("BadgeUnearned"))
            Spacer()
        }.padding(.leading, 20)
    }

}



struct ActionButton: View {
    let image: Image
    let pressable: Bool
    let thisTitle: String


    var buttonWidth = UIScreen.main.bounds.size.width / 3.0 - (5.0 * 3.0)

    var body: some View{
        return
            Button(action: {print("Action Button Pressed")}) {

                ZStack {
                    if(pressable == true) {
                        RoundedRectangle(cornerRadius: 20)
                        .fill(Color("BadgeEarned"))
                        .frame(width: buttonWidth, height: 100, alignment:.center)
                        .padding(.all, 5)

                    }
                    else {
                        RoundedRectangle(cornerRadius: 20)
                        .fill(Color("BadgeUnearned"))
                        .frame(width: buttonWidth, height: 100, alignment:.center)
                        .padding(.all, 5)
                    }

                    VStack {
                        image
                            .foregroundColor(.black)
                        Text(thisTitle)
                            .foregroundColor(.black)
                    }
                }
            }
    }



}
