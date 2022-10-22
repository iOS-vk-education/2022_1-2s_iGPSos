//
//  LooksListContainer.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit

final class LooksListContainer {
    let input: LooksListModuleInput
	let viewController: UIViewController
	private(set) weak var router: LooksListRouterInput!

	class func assemble(with context: LooksListContext) -> LooksListContainer {
        let router = LooksListRouter()
        let interactor = LooksListInteractor()
        let presenter = LooksListPresenter(router: router, interactor: interactor)
		let viewController = LooksListViewController(output: presenter)
        router.viewController = viewController

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return LooksListContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: LooksListModuleInput, router: LooksListRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct LooksListContext {
	weak var moduleOutput: LooksListModuleOutput?
}
