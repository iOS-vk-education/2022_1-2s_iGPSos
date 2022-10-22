//
//  ProfileContainer.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit

final class ProfileContainer {
    let input: ProfileModuleInput
	let viewController: UIViewController
	private(set) weak var router: ProfileRouterInput!

	class func assemble(with context: ProfileContext) -> ProfileContainer {
        let router = ProfileRouter()
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter(router: router, interactor: interactor)
		let viewController = ProfileViewController(output: presenter)
        router.viewController = viewController

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return ProfileContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ProfileModuleInput, router: ProfileRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ProfileContext {
	weak var moduleOutput: ProfileModuleOutput?
}
