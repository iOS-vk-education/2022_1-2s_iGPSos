//
//  AuthUser.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 09.11.2022.
//

import Foundation
import Firebase
import CombineFirebaseAuthentication
import Combine

class AuthUser {
    static let shared = AuthUser()
    
    func createAccountUser(with name: String, email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
    
    func loginUser(with email: String, password: String ) -> AnyPublisher<User, Error> {
        return Auth.auth().signIn(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
}
