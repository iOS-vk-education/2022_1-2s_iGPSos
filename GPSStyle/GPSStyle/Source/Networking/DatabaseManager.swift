//
//  DatabaseManager.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 18.12.2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import CombineFirebaseAuthentication
import Combine

class DatabaseManager {
    static let shared = DatabaseManager()
    
    let db = Firestore.firestore()
    let usersPath: String = "users"
    
    func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
        let gpsUser = GpsUser(from: user)
        return db.collection(usersPath).document(gpsUser.id).setDate(GpsUser)
    }
}
