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
    var countList: Int { get }
    var getSections: [ClothesSection] { get }
    func clothDidTap(with index: IndexPath)
    
    func getSectionCount() -> Int
    func getCellCount(in section: Int) -> Int
    func getTitle(for section: Int) -> String
    func getCell(at index: IndexPath) -> ClothesRow
    func removeCell(at index: IndexPath)
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
    func goToAboutCloth(presenter: ClothesListModuleInput)
}
