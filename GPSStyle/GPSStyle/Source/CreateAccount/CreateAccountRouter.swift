//
//  CreateAccountRouter.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 01.11.2022.
//

import UIKit

final class CreateAccountRouter {
    weak var viewController: UIViewController?
}

extension CreateAccountRouter: CreateAccountRouterInput {
    func goToMainScreen() {
        let vc = MainTabBarController.init(tabBarModel: TabBarModelImpl())
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true, completion: nil)
    }
    
    func gotToLoginScreen() {
        let vc = LoginContainer.assemble(with: LoginContext()).viewController
        viewController?.present(vc, animated: true, completion: nil)
    }
}
