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
    private var data: [LookModel] = []
    
    init(router: LooksListRouterInput, interactor: LooksListInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LooksListPresenter: LooksListModuleInput {
}

extension LooksListPresenter: CreateLookModuleOutput {
    func update() {
        getData()
    }
}

extension LooksListPresenter: LooksListViewOutput {
    func getData() {
        view?.update(with: .init(state: .isLoading, config: lookConfig))
        interactor.fetchLooks()
    }
    
    func getLook(index: Int) -> LookModel {
        data[index]
    }
    
    var countList: Int {
        data.count
    }
    
    func addButtonDidTap() {
        router.goToAddLookScreen(presenter: self)
    }
}

extension LooksListPresenter: LooksListInteractorOutput {
    func clothDidLoad(with array: [LookModel]) {
        data = array
        view?.update(with: (data.isEmpty ? .init(state: .empty, config: lookConfig) : .init(state: .success, config: lookConfig)))
    }
}
