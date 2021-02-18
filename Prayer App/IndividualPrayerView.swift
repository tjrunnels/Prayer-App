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
        
        ZStack {
//            Rectangle()
//                .frame(width: .infinity, height: .infinity, alignment: .center)
//                .ignoresSafeArea(.all, edges: .all)
//                .foregroundColor(Color("iosDefaultGreyBackground"))
            VStack(alignment: .leading){
                
            //Title
                Group {
                    Text("Prayer")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding([.leading], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .padding(.bottom, 1)
                    Text(prayer.name)
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
                    Text(prayer.description!)
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
                    Text("@" + prayer.createdBy!)
                        .font(.body)
                        .padding([.leading], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.gray)

                    Divider()
                }

               
                
            //Badges
                Group {
                    Text("Badges")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)
                        .padding([.top, .leading], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .padding(.bottom, 1)
                    //badges
                    VStack {
                        myBadges.contains(1) ? DetailedPrayerBadge(image: Image(systemName: "checkmark.circle"), earned: true, thisTitle: "Saved", thisDescription: "this prayer is in the cloud") : nil
                        myBadges.contains(2) ? DetailedPrayerBadge(image: Image(systemName: "person.3"), earned: true, thisTitle: "2 or More", thisDescription: "More than 2 differnt people have prayed for this") : nil
                        myBadges.contains(3) ? DetailedPrayerBadge(image: Image(systemName: "sun.max"), earned: true, thisTitle: "Answered", thisDescription: "Prayer has been answered") : nil
                    }
                    Divider()
                }

                
         
          
                
    
                
                Text("Actions")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.black)
                    .padding([.top, .leading], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 1)

                //badges
                HStack {
                    myBadges.contains(1) ? ActionButton(image: Image(systemName: "checkmark.circle"), pressable: true, thisTitle: "Save to List") : nil
                    myBadges.contains(2) ? ActionButton(image: Image(systemName: "person.3"), pressable: true, thisTitle: "Prayed For") : nil
                    myBadges.contains(3) ? ActionButton(image: Image(systemName: "sun.max"), pressable: false, thisTitle: "Add Answer") : nil
                }
                Spacer()
            }
            
            .multilineTextAlignment(.leading)
            .padding(.top, -30) //tomdo: should prob not have this... idk why the defualt is so low tho
            
            
            
        }
        
        
        
    }
    
    
}

struct IndividualPrayerView_Previews: PreviewProvider {
    
    
    static var previews: some View {
    
        NavigationView {
            IndividualPrayerView(prayer: Prayer(id : UUID().uuidString, name: "Grinders Hunger for Wisdom", description: "That they would seek it like silver", createdBy: "tom_runnels"))
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
        }.padding(.leading, 20  )
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
