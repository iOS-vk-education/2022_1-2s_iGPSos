//
//  TabBarModel.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//

import UIKit

protocol TabBarModel: AnyObject {
    func generateTabBars() -> [UIViewController]
}

final class TabBarModelImpl: TabBarModel {
    func generateTabBars() -> [UIViewController] {
        [generateVC(
            viewController:
                HomeContainer.assemble(with: HomeContext()).viewController,
            image: Asset.tabHome.image,
            selectedImage: Asset.tabHomeFilled.image
        ),
         generateVC(
            viewController:
                ClothesListContainer.assemble(with: ClothesListContext()).viewController,
            image: Asset.tabClothes.image,
            selectedImage: Asset.tabClothesFilled.image
        ),
         generateVC(
            viewController:
                LooksListContainer.assemble(with: LooksListContext()).viewController,
            image: Asset.tabLooks.image,
            selectedImage: Asset.tabLooksFilled.image
        ),
         generateVC(
            viewController:
                ProfileContainer.assemble(with: ProfileContext()).viewController,
            image: Asset.tabProfile.image,
            selectedImage: Asset.tabProfileFilled.image
        )]
    }
    
    private func generateVC(viewController: UIViewController, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        let icon = UITabBarItem(
            title: nil,
            image: image,
            selectedImage: selectedImage
        )
        viewController.tabBarItem = icon
        
        return viewController
    }
}
