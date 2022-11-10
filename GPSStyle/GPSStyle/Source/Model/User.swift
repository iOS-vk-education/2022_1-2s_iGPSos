//
//  User.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 09.11.2022.
//

import Foundation
import Firebase
import Combine

final class CreateAccountModel: ObservableObject {
    @Published var name: String?
    @Published var email: String?
    @Published var password: String?
    @Published var isCreateAccountFormValid: Bool = false
    @Published var user: User?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func validateCreateAccountForm() {
        guard let email = email,
              let password = password else {
            isCreateAccountFormValid = false
            return
        }
        isCreateAccountFormValid = isValidEmail(email) && password.count >= 8
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func createUser() {
        guard let name = name,
              let email = email,
              let password = password else { return }
        AuthUser.shared.createAccountUser(with: name, email: email, password: password)
            .sink { _ in
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)
    }
}
