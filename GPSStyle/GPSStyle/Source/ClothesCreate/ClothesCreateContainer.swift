//
//  ClothesCreateContainer.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 29.10.2022.
//

import UIKit

final class ClothesCreateContainer {
    let input: ClothesCreateModuleInput
    let viewController: UIViewController
    private(set) weak var router: ClothesCreateRouterInput!
    
    class func assemble(with context: ClothesCreateContext) -> ClothesCreateContainer {
        let router = ClothesCreateRouter()
        let interactor = ClothesCreateInteractor()
        let presenter = ClothesCreatePresenter(router: router, interactor: interactor)
        let viewController = ClothesCreateViewController(output: presenter)
        router.viewController = viewController
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return ClothesCreateContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ClothesCreateModuleInput, router: ClothesCreateRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ClothesCreateContext {
    weak var moduleOutput: ClothesCreateModuleOutput?
}
