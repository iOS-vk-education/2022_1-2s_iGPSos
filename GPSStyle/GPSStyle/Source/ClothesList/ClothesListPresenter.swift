//
//  ClothesListPresenter.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import Foundation

final class ClothesListPresenter {
	weak var view: ClothesListViewInput?
    weak var moduleOutput: ClothesListModuleOutput?

	private let router: ClothesListRouterInput
	private let interactor: ClothesListInteractorInput

    init(router: ClothesListRouterInput, interactor: ClothesListInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ClothesListPresenter: ClothesListModuleInput {
}

extension ClothesListPresenter: ClothesListViewOutput {
}

extension ClothesListPresenter: ClothesListInteractorOutput {
}
