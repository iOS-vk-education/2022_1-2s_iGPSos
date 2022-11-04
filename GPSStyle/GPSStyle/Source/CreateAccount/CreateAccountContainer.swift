//
//  CreateAccountContainer.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit

final class CreateAccountContainer {
    let input: CreateAccountModuleInput
    let viewController: UIViewController
    private(set) weak var router: CreateAccountRouterInput!
    
    class func assemble(with context: CreateAccountContext) -> CreateAccountContainer {
        let router = CreateAccountRouter()
        let interactor = CreateAccountInteractor()
        let presenter = CreateAccountPresenter(router: router, interactor: interactor)
        let viewController = CreateAccountViewController(output: presenter)
        router.viewController = viewController
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return CreateAccountContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: CreateAccountModuleInput, router: CreateAccountRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct CreateAccountContext {
    weak var moduleOutput: CreateAccountModuleOutput?
}
