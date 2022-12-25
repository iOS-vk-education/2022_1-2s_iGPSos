//
//  ClothesCreatePresenter.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 29.10.2022.
//

import Foundation

final class ClothesCreatePresenter {
    weak var view: ClothesCreateViewInput?
    weak var moduleOutput: ClothesCreateModuleOutput?
    
    private let router: ClothesCreateRouterInput
    private let interactor: ClothesCreateInteractorInput
    
    init(router: ClothesCreateRouterInput, interactor: ClothesCreateInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ClothesCreatePresenter: ClothesCreateModuleInput {
}

extension ClothesCreatePresenter: ClothesCreateViewOutput {
    func didTapCreateClothes(model: ClothesModel) {
        interactor.createClothes(model: model)
    }
}

extension ClothesCreatePresenter: ClothesCreateInteractorOutput {
}
