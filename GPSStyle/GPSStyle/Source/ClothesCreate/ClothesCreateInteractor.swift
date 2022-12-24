//
//  ClothesCreateInteractor.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 29.10.2022.
//

import Foundation

final class ClothesCreateInteractor: CreateLookServiceOutput {
    func faild() {

    }
    
    func success() {
        
    }
    
    weak var output: ClothesCreateInteractorOutput?
    var createClothesService: CreateClothesServiceInput?
    
    init() {
        createClothesService = CreateClothesService(interactor: self)
    }
}

extension ClothesCreateInteractor: ClothesCreateInteractorInput {
    func createClothes(model: ClothesModel) {
        createClothesService?.createClothes(model: model)
    }
}
