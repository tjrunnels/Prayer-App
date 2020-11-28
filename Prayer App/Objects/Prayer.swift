//
//  Prayer.swift
//  Prayer App
//
//  Created by tomrunnels on 11/27/20.
//

import Foundation
import SwiftUI



// the data class to represents Prayers
class Prayer : Identifiable, ObservableObject {
    var id : String
    var name : String
    var description : String?
    var imageName : String?
    var createdBy : String?
    @Published var image : Image?

    init(id: String, name: String, description: String? = nil, image: String? = nil, createdBy: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.imageName = image
        self.createdBy = createdBy
    }
    convenience init(from data: PrayerData) {
        self.init(id: data.id, name: data.name, description: data.description, image: data.image, createdBy: data.createdBy)
        
        //s3 api call
        if let name = self.imageName {
                // asynchronously download the image
                AWS_Backend.shared.retrieveImage(name: name) { (data) in
                    // update the UI on the main thread
                    DispatchQueue.main.async() {
                        let uim = UIImage(data: data)
                        self.image = Image(uiImage: uim!)
                    }
                }
            }
     
        // store API object for easy retrieval later
        self._data = data
    }

    fileprivate var _data : PrayerData?

    // access the privately stored PrayerData or build one if we don't have one.
    var data : PrayerData {

        if (_data == nil) {
            _data = PrayerData(id: self.id,
                                name: self.name,
                                description: self.description,
                                image: self.imageName,
                                createdBy: self.createdBy)
        }

        return _data!
    }

}
