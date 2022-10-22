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
            viewController: ViewController(),
            image: Asset.tabHome.image,
            selectedImage: Asset.tabHomeFilled.image
        ),
         generateVC(
            viewController: ViewController(),
            image: UIImage(systemName: "person.fill"),
            selectedImage: UIImage(systemName: "house.fill")
        ),
         generateVC(
            viewController: ViewController(),
            image: UIImage(systemName: "person.fill"),
            selectedImage: UIImage(systemName: "house.fill")
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
