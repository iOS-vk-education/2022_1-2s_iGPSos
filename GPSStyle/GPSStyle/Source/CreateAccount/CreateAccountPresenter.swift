//
//  CreateAccountPresenter.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 01.11.2022.
//

import Foundation

final class CreateAccountPresenter {
    weak var view: CreateAccountViewInput?
    weak var moduleOutput: CreateAccountModuleOutput?
    
    private let router: CreateAccountRouterInput
    private let interactor: CreateAccountInteractorInput
    
    init(router: CreateAccountRouterInput, interactor: CreateAccountInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CreateAccountPresenter: CreateAccountModuleInput {
}

extension CreateAccountPresenter: CreateAccountViewOutput {
    func didTapCreateAccount() {
        router.goToMainScreen()
    }
    
    func didTapLoginButton() {
        router.gotToLoginScreen()
    }
}

extension CreateAccountPresenter: CreateAccountInteractorOutput {
}
