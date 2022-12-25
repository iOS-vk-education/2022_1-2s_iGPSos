//
//  ClothesListProtocols.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import Foundation

protocol ClothesListModuleInput {
    var moduleOutput: ClothesListModuleOutput? { get }
}

protocol ClothesListModuleOutput: AnyObject {
}

protocol ClothesListViewInput: AnyObject {
    func reloadData()
}

protocol ClothesListViewOutput: AnyObject {
    func addButtonDidTap()
    func viewWillAppear()
    func getCloth(index: Int) -> ClothingModel
    var countList: Int { get }
}

protocol ClothesListInteractorInput: AnyObject {
    func fetchClothing()
}

protocol ClothesListInteractorOutput: AnyObject {
    func clothDidLoad(with array: [ClothingModel])
}

protocol ClothesListRouterInput: AnyObject {
    func goToAddClothesScreen()
}
