//
//  LoginProtocols.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 01.11.2022.
//

import Foundation

protocol LoginModuleInput {
    var moduleOutput: LoginModuleOutput? { get }
}

protocol LoginModuleOutput: AnyObject {
}

protocol LoginViewInput: AnyObject {
}

protocol LoginViewOutput: AnyObject {
}

protocol LoginInteractorInput: AnyObject {
}

protocol LoginInteractorOutput: AnyObject {
}

protocol LoginRouterInput: AnyObject {
}
