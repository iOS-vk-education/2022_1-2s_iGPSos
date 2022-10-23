//
//  HomePresenter.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import Foundation

final class HomePresenter {
    weak var view: HomeViewInput?
    weak var moduleOutput: HomeModuleOutput?
    
    private let router: HomeRouterInput
    private let interactor: HomeInteractorInput
    
    init(router: HomeRouterInput, interactor: HomeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomeModuleInput {
}

extension HomePresenter: HomeViewOutput {
}

extension HomePresenter: HomeInteractorOutput {
}
