//
//  CreateLookPresenter.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.11.2022.
//  
//

import Foundation

final class CreateLookPresenter {
	weak var view: CreateLookViewInput?
    weak var moduleOutput: CreateLookModuleOutput?

	private let router: CreateLookRouterInput
	private let interactor: CreateLookInteractorInput
    private var data: [ClothesLookCreate] = []
    
    init(router: CreateLookRouterInput, interactor: CreateLookInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CreateLookPresenter: CreateLookModuleInput {
}

extension CreateLookPresenter: CreateLookViewOutput {
    func viewDidLoad() {
        interactor.fetchCloths()
    }
    
    func createLook(with title: String?) {
        guard let title = title, !title.isEmpty else {
            return
        }
        let filteredDataUuid = data.filter { cloth in
            cloth.isSelected
        }.map {
            $0.uuid
        }
        let filteredDataImages = data.filter { cloth in
            cloth.isSelected
        }.map {
            $0.imageName
        }
        guard !filteredDataUuid.isEmpty, !filteredDataImages.isEmpty  else {
            return
        }
        interactor.createLook(
            with: title,
            images: filteredDataImages,
            and: filteredDataUuid
        )
    }
    
    func getCloth(index: Int) -> ClothesLookCreate {
        data[index]
    }
    
    var countList: Int {
        data.count
    }
    
    func updateIsSelected(index: Int) {
        data[index].isSelected = !data[index].isSelected
    }
}

extension CreateLookPresenter: CreateLookInteractorOutput {
    func clothDidLoad(with array: [ClothesLookCreate]) {
        data = array
        view?.reloadData()
    }
    
    func finishCreatingLook() {
        moduleOutput?.update()
        router.closeVC()
    }
}
