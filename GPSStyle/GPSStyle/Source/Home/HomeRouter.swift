//
//  HomeRouter.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit
import SwiftUI

final class HomeRouter {
    weak var viewController: UIViewController?
}

extension HomeRouter: HomeRouterInput {
    func goToCreateMeeting(presenter: HomeModuleInput) {
        let meetingViewController = MeetingViewController()
        meetingViewController.delegate = presenter
        viewController?.navigationController?.pushViewController(meetingViewController, animated: true)
    }
    
    func goToAboutCloth(model: ClothingModel) {
        let clothesAboutViewModel = ClothesAboutViewModel(clothingModel: model)
        let clothesAboutView = ClothesAboutView(viewModel: clothesAboutViewModel)
        let hosting = UIHostingController(rootView: clothesAboutView)
        viewController?.navigationController?.pushViewController(hosting, animated: true)
    }
}
