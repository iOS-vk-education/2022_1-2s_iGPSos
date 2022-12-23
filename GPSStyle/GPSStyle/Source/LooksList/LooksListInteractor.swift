//
//  LooksListInteractor.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import Foundation

final class LooksListInteractor {
    weak var output: LooksListInteractorOutput?
    var getLooksService: GetLooksServiceInput?
    
    init() {
        getLooksService = GetLooksService(interactor: self)
    }
}

extension LooksListInteractor: LooksListInteractorInput {
    func fetchLooks() {
        getLooksService?.fetchLooks()
    }
}

extension LooksListInteractor: GetLooksServiceOutput {
    func faild() {
    }
    
    func success(with array: [LookModel]) {
        output?.clothDidLoad(with: array)
    }
}
    
