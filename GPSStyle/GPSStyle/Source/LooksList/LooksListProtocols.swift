//
//  LooksListProtocols.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import Foundation

protocol LooksListModuleInput {
    var moduleOutput: LooksListModuleOutput? { get }
}

protocol LooksListModuleOutput: AnyObject {
}

protocol LooksListViewInput: AnyObject {
    func update(with state: ControllerState)
}

protocol LooksListViewOutput: AnyObject {
    func addButtonDidTap()
    func getData()
    func getLook(index: Int) -> LookModel
    func removeLook(for ind: Int)
    var countList: Int { get }
}

protocol LooksListInteractorInput: AnyObject {
    func fetchLooks()
    func deleteLookClothing(for look: LookModel)
}

protocol LooksListInteractorOutput: AnyObject {
    func clothDidLoad(with array: [LookModel])
}

protocol LooksListRouterInput: AnyObject {
    func goToAddLookScreen(presenter: CreateLookModuleOutput)
}
