//
//  ClothesCreateRouter.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 29.10.2022.
//

import UIKit

final class ClothesCreateRouter {
    weak var viewController: UIViewController?
}

extension ClothesCreateRouter: ClothesCreateRouterInput {
    func closeVC() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
