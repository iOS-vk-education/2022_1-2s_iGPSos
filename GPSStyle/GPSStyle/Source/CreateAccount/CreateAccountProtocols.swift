//
//  CreateAccountProtocols.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 01.11.2022.
//

import Foundation

protocol CreateAccountModuleInput {
    var moduleOutput: CreateAccountModuleOutput? { get }
}

protocol CreateAccountModuleOutput: AnyObject {
}

protocol CreateAccountViewInput: AnyObject {
}

protocol CreateAccountViewOutput: AnyObject {
    func didTapCreateAccount()
    func didTapLoginButton()
}

protocol CreateAccountInteractorInput: AnyObject {
}

protocol CreateAccountInteractorOutput: AnyObject {
}

protocol CreateAccountRouterInput: AnyObject {
    func goToMainScreen()
    func gotToLoginScreen()
}
