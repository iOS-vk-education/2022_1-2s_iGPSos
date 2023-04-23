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
    private var data: [ClothesSection] = []
    
    init(router: ClothesListRouterInput, interactor: ClothesListInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ClothesListPresenter: ClothesListModuleInput {
}

extension ClothesListPresenter: ClothesListViewOutput {
    func getCloth(index: Int) -> ClothingModel {
        return ClothingModel.init(uuid: "", name: "", imageName: "", specification: SpecificationModel.init(brand: "", category: "", size: "")) //data[index].rows
    }
    
    func removeCloth(for ind: Int) {
//        interactor.deleteClthClothing(for: data[ind])
//        data.remove(at: ind)
    }
    
    var countList: Int {
        data.count
    }
    
    func viewWillAppear() {
        interactor.fetchClothing()
    }
    
    func addButtonDidTap() {
        router.goToAddClothesScreen()
    }
}

extension ClothesListPresenter: ClothesListInteractorOutput {
    func clothDidLoad(with array: [ClothesSection]) {
        data = array
        view?.reloadData()
    }
}
