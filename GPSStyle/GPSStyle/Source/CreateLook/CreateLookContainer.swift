//
//  CreateLookContainer.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.11.2022.
//  
//

import UIKit

final class CreateLookContainer {
    let input: CreateLookModuleInput
	let viewController: UIViewController
	private(set) weak var router: CreateLookRouterInput!

	class func assemble(with context: CreateLookContext) -> CreateLookContainer {
        let router = CreateLookRouter()
        let interactor = CreateLookInteractor()
        let presenter = CreateLookPresenter(router: router, interactor: interactor)
		let viewController = CreateLookViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        router.viewController = viewController
        return CreateLookContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: CreateLookModuleInput, router: CreateLookRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct CreateLookContext {
	weak var moduleOutput: CreateLookModuleOutput?
}
