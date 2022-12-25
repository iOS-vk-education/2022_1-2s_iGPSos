//
//  HomeRouter.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit

final class HomeRouter {
    weak var viewController: UIViewController?
}

extension HomeRouter: HomeRouterInput {
    func goToCreateMeeting() {
        let meetingViewController = MeetingViewController()
        viewController?.navigationController?.pushViewController(meetingViewController, animated: true)
    }
}
