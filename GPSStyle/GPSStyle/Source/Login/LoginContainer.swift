//
//  LoginContainer.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit

final class LoginContainer {
    let input: LoginModuleInput
    let viewController: UIViewController
    private(set) weak var router: LoginRouterInput!
    
    class func assemble(with context: LoginContext) -> LoginContainer {
        let router = LoginRouter()
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(router: router, interactor: interactor)
        let viewController = LoginViewController(output: presenter)
        router.viewController = viewController
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return LoginContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: LoginModuleInput, router: LoginRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct LoginContext {
    weak var moduleOutput: LoginModuleOutput?
}
