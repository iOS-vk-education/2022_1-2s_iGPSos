//
//  LoginPresenter.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 01.11.2022.
//

import Foundation

final class LoginPresenter {
    weak var view: LoginViewInput?
    weak var moduleOutput: LoginModuleOutput?
    
    private let router: LoginRouterInput
    private let interactor: LoginInteractorInput
    
    init(router: LoginRouterInput, interactor: LoginInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LoginPresenter: LoginModuleInput {
}

extension LoginPresenter: LoginViewOutput {
    func didTapCreateAccount() {
        router.goToMainScreen()
    }
}

extension LoginPresenter: LoginInteractorOutput {
}
