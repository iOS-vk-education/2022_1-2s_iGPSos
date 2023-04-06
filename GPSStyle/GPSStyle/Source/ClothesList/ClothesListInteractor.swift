//
//  ClothesListInteractor.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import Foundation

final class ClothesListInteractor {
    weak var output: ClothesListInteractorOutput?
    var getClothingService: GetClothesServiceInput?
    
    init() {
        getClothingService = GetClothesService(interactor: self)
    }
}

extension ClothesListInteractor: ClothesListInteractorInput {
    func fetchClothing() {
        getClothingService?.fetchClothing()
    }

    func deleteClthClothing(for clth: ClothingModel) {
        getClothingService?.delClothing(clth: clth)
    }
}

extension ClothesListInteractor: GetClothesServiceOutput {
    func faild() {
    }
    
    func success(with array: [ClothingModel]) {
        output?.clothDidLoad(with: array)
    }
}
