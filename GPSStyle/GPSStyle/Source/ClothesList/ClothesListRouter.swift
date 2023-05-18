//
//  ClothesListRouter.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit
import Foundation
import SwiftUI

final class ClothesListRouter {
    weak var viewController: UIViewController?
}

extension ClothesListRouter: ClothesListRouterInput {
    func goToAddClothesScreen() {
        let container = ClothesCreateContainer.assemble(with: ClothesCreateContext(clothesRow: nil))
        viewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }
    
    func goToAboutCloth(model: ClothingModel) {
        let clothesAboutViewModel = ClothesAboutViewModel(clothingModel: model)
        let clothesAboutView = ClothesAboutView(viewModel: clothesAboutViewModel)
        let hosting = UIHostingController(rootView: clothesAboutView)
        viewController?.navigationController?.pushViewController(hosting, animated: true)
    }
}
