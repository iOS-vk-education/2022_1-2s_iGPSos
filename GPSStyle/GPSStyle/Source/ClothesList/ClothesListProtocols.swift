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
    func deleteClthClothing(for clth: ClothingModel)
}

protocol ClothesListViewInput: AnyObject {
    func reloadData()
}

protocol ClothesListViewOutput: AnyObject {
    func addButtonDidTap()
    func viewWillAppear()
    func getCloth(index: Int) -> ClothingModel
    func removeCloth(for ind: Int)
    var countList: Int { get }
}

protocol ClothesListInteractorInput: AnyObject {
    func fetchClothing()
    func deleteClthClothing(for clth: ClothingModel)
}

protocol ClothesListInteractorOutput: AnyObject {
    func clothDidLoad(with array: [ClothesSection])
}

protocol ClothesListRouterInput: AnyObject {
    func goToAddClothesScreen()
}
