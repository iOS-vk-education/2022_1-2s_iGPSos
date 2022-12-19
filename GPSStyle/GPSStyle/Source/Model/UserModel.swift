//
//  UserModel.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 18.12.2022.
//

import Foundation
import Firebase

struct GpsUser: Codable {
    let id: String
    var username: String = ""
    var email: String = ""
    
    init(from user: User) {
        self.id = user.uid
    }
}
