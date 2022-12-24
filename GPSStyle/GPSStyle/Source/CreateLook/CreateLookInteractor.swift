//
//  CreateLookInteractor.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.11.2022.
//  
//

import Foundation

final class CreateLookInteractor {
	weak var output: CreateLookInteractorOutput?
    var createLookService: CreateLookServiceInput?
    var getClothsService: GetClothsServiceInput?
    
    init() {
        createLookService = CreateLookService(interactor: self)
        getClothsService = GetClothsService(interactor: self)
    }
}

extension CreateLookInteractor: CreateLookInteractorInput {
    func fetchCloths() {
        getClothsService?.fetchCloth()
    }
    
    func createLook(with title: String?, images: [String], and clothId: [String]) {
        createLookService?.createLook(with: title, images: images, and: clothId)
    }
}

extension CreateLookInteractor: CreateLookServiceOutput, GetClothsServiceOutput {
    func faild() {
    }
    
    func success(with array: [ClothesLookCreate]) {
        output?.clothDidLoad(with: array)
    }
    
    func success() {
        output?.finishCreatingLook()
    }
}
