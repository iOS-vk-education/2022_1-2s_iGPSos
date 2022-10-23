//
//  LooksListPresenter.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import Foundation

final class LooksListPresenter {
    weak var view: LooksListViewInput?
    weak var moduleOutput: LooksListModuleOutput?
    
    private let router: LooksListRouterInput
    private let interactor: LooksListInteractorInput
    
    init(router: LooksListRouterInput, interactor: LooksListInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LooksListPresenter: LooksListModuleInput {
}

extension LooksListPresenter: LooksListViewOutput {
}

extension LooksListPresenter: LooksListInteractorOutput {
}
