//
//  ViewController.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    var tabBarModel: TabBarModel?
    let roundLayer = CAShapeLayer()

    private enum Constants {
        static let positionOnX: CGFloat = 57.0
        static let TabBarHeight: CGFloat = 57.0
        static let bottomInsets: CGFloat = 37.0
        static let shadowOpacity: Float = 0.25
        static let shadowRadius: CGFloat = 4.0
        static let tabBarYMargin: CGFloat = 5.0
    }
    
    init(tabBarModel: TabBarModel?) {
        self.tabBarModel = tabBarModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupViewControllers()
        setupTabBarAppearance()
        setupTabColor()
        setupTabBarShadow()
    }
    
    private func setupViewControllers() {
        guard let tabBarModel = tabBarModel else {
            assertionFailure("Faild to get viewControllers")
            return
        }
        viewControllers = tabBarModel.generateTabBars().map({ viewController in
            let navigationController = UINavigationController(rootViewController: viewController)
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = ColorName.white.color
            appearance.titleTextAttributes = [.foregroundColor: ColorName.black.color]
            navigationController.navigationBar.tintColor = ColorName.black.color
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.compactAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
            return navigationController
        })
    }

    private func setupTabBarAppearance() {
        let width = tabBar.bounds.width - Constants.positionOnX
        let height = Constants.TabBarHeight
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: Constants.positionOnX / 2,
                y: tabBar.bounds.midY - height / 2 - Constants.tabBarYMargin,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 7
        tabBar.itemPositioning = .centered
        additionalSafeAreaInsets.bottom = Constants.bottomInsets
    }

    private func setupTabColor() {
        roundLayer.fillColor = ColorName.white.color.cgColor
    }

    private func setupTabBarShadow() {
        roundLayer.shadowColor = ColorName.black.color.cgColor
        roundLayer.shadowOpacity = Constants.shadowOpacity
        roundLayer.shadowOffset = .zero
        roundLayer.shadowRadius = Constants.shadowRadius
    }
}
