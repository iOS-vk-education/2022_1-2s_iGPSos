//
//  LoginRouter.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 01.11.2022.
//

import UIKit

final class LoginRouter {
    static let shared = LoginRouter()
    
    init() {}
    
  func gotoMainTabBarController(from source: UIViewController) {
      let tabBarController = MainTabBarController(tabBarModel: TabBarModelImpl())
      tabBarController.modalPresentationStyle = .fullScreen
      source.present(tabBarController, animated: true, completion: nil)
    }
}
