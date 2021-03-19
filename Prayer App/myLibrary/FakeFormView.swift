//
//  FakeFormView.swift
//  Prayer App
//
//  Created by tomrunnels on 3/17/21.
//

import SwiftUI


/// Creates and returns a view inside what appears like a form view with a navigation title.  Very native iOS looking
struct FakeFormView<Content: View>: View {
    
    let content: Content
    let title: String
    var spacerHeight: CGFloat = 0
        
    init(viewTitle: String, spacer: CGFloat, @ViewBuilder content: () -> Content) {
        self.title = viewTitle
        self.content = content()
        self.spacerHeight = spacer
    }
    
    init(viewTitle: String, @ViewBuilder content: () -> Content) {
        self.title = viewTitle
        self.content = content()
    }
    
    init(@ViewBuilder content: () -> Content) {
        self.title = ""
        self.content = content()
    }
    
    var body: some View {
        
        ZStack {
            Color(.systemGray6).ignoresSafeArea(.all, edges: .all)
            VStack {
                HStack {
                    Text(title)
                        .font(.largeTitle)
                        .bold()
                        .padding(.all,20)
                        .padding(.top,10)
                    Spacer()
                }
                Spacer().frame(height: spacerHeight)
                self.content
                Spacer()
            }
        }
    }
}

struct FakeFormView_Previews: PreviewProvider {
    

    
    static var previews: some View {
        FakeFormView(viewTitle: "helloWrold"){

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
        }
    }
}





//
//struct FakeFormCustomTextField: View {
//
//    var placeholderText: String
//    var textBinding:
//
//    var body: some View {
//        CustomTextField(placeholderText: "suppm500@gmail.com", text: $email)
//            .frame(width: .infinity, height: 50)
//            .background(Color(.white))
//            .cornerRadius(10)
//            .padding([.leading, .trailing], 20)
//    }
//}
