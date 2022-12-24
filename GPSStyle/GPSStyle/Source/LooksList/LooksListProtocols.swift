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
    func reloadData()
}

protocol LooksListViewOutput: AnyObject {
    func addButtonDidTap()
    func viewWillAppear()
    func getLook(index: Int) -> LookModel
    var countList: Int { get }
}

protocol LooksListInteractorInput: AnyObject {
    func fetchLooks()
}

protocol LooksListInteractorOutput: AnyObject {
    func clothDidLoad(with array: [LookModel])
}

protocol LooksListRouterInput: AnyObject {
    func goToAddLookScreen()
}
