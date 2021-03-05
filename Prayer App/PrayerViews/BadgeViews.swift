//
//  BadgeViews.swift
//  Prayer App
//
//  Created by tomrunnels on 3/5/21.
//

import SwiftUI


struct PrayerBadge: View {
    let type: PrayerBadgeType
    
    var body: some View{
        return ZStack {
            
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


