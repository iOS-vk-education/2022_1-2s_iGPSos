//
//  ClothesListContainer.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit

final class ClothesListContainer {
    let input: ClothesListModuleInput
	let viewController: UIViewController
	private(set) weak var router: ClothesListRouterInput!

	class func assemble(with context: ClothesListContext) -> ClothesListContainer {
        let router = ClothesListRouter()
        let interactor = ClothesListInteractor()
        let presenter = ClothesListPresenter(router: router, interactor: interactor)
		let viewController = ClothesListViewController(output: presenter)
        router.viewController = viewController

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return ClothesListContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ClothesListModuleInput, router: ClothesListRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ClothesListContext {
	weak var moduleOutput: ClothesListModuleOutput?
}
