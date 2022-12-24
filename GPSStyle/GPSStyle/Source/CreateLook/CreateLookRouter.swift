//
//  CreateLookRouter.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.11.2022.
//  
//

import UIKit

final class CreateLookRouter {
    weak var viewController: UIViewController?
}

extension CreateLookRouter: CreateLookRouterInput {
    func closeVC() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
