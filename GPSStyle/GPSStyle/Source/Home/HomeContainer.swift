//
//  HomeContainer.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit

final class HomeContainer {
    let input: HomeModuleInput
    let viewController: UIViewController
    private(set) weak var router: HomeRouterInput!
    
    class func assemble(with context: HomeContext) -> HomeContainer {
        let router = HomeRouter()
        let interactor = HomeInteractor()
        let presenter = HomePresenter(router: router, interactor: interactor)
        let viewController = HomeViewController(output: presenter)
        router.viewController = viewController
        
        let navigationController = UINavigationController(rootViewController: viewController)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = ColorName.white.color
        appearance.titleTextAttributes = [.foregroundColor: ColorName.black.color]
        navigationController.navigationBar.tintColor = ColorName.black.color
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance

        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return HomeContainer(view: navigationController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: HomeModuleInput, router: HomeRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct HomeContext {
    weak var moduleOutput: HomeModuleOutput?
}
