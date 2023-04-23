//
//  ClothesListRouter.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit

final class ClothesListRouter {
    weak var viewController: UIViewController?
}

extension ClothesListRouter: ClothesListRouterInput {
    func goToAddClothesScreen() {
        let container = ClothesCreateContainer.assemble(with: ClothesCreateContext(clothesRow: nil))
        viewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }
}
