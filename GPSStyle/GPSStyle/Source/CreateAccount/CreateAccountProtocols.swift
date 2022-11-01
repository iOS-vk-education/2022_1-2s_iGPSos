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
}

protocol CreateAccountInteractorInput: AnyObject {
}

protocol CreateAccountInteractorOutput: AnyObject {
}

protocol CreateAccountRouterInput: AnyObject {
}
