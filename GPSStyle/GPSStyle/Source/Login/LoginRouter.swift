//
//  LoginRouter.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 01.11.2022.
//

import UIKit

final class LoginRouter {
    weak var viewController: UIViewController?
}

extension LoginRouter: LoginRouterInput {
    func goToMainScreen() {
        let vc = MainTabBarController.init(tabBarModel: TabBarModelImpl())
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true, completion: nil)
    }
}
