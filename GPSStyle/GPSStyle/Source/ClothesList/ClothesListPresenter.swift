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
    private var tableData: [ClothesSectionPresenter] = []
    
    init(router: ClothesListRouterInput, interactor: ClothesListInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ClothesListPresenter: ClothesListModuleInput {
}

extension ClothesListPresenter: ClothesListViewOutput {
    func getCloth(index: Int) -> ClothingModel {
        return ClothingModel.init(uuid: "",
                                  name: "",
                                  imageName: "",
                                  specification: SpecificationModel.init(brand: "",
                                                                         category: "",
                                                                         size: ""))
    }
    
    var countList: Int {
        data.count
    }
    
    var getSections: [ClothesSection] {
        return data
    }
    
    func viewWillAppear() {
        interactor.fetchClothing()
    }
    
    func addButtonDidTap() {
        router.goToAddClothesScreen()
    }
    
    func getTitle(for section: Int) -> String {
        return tableData[section].title
    }
    
    func getCell(at index: IndexPath) -> ClothesRow {
        return tableData[index.section].clothers[index.row]
    }
    
    func getSectionCount() -> Int {
        return tableData.count
    }
    
    // Получение числа ячеек в секции
    func getCellCount(in section: Int) -> Int {
        return tableData[section].clothers.count
    }
    
    // Удаление конкретной ячейки
    func removeCell(at index: IndexPath) {
        // Создание модели одежды для передачи интерактору
        let clothCell = tableData[index.section].clothers[index.row]
        let clothId = clothCell.id
        let clothTitle = clothCell.title
        let clothImage = clothCell.imageUrl
        let clothSpec = clothCell.specification
        let clothModel = ClothingModel(uuid: clothId, name: clothTitle, imageName: clothImage, specification: clothSpec)
        
        // Удаление из локального массива
        tableData[index.section].clothers.remove(at: index.row)
        
        // Проверка на опустошение секции
        let cellCount = getCellCount(in: index.section)
        if cellCount == 0 {
            tableData.remove(at: index.section)
        }
        
        interactor.deleteClthClothing(for: clothModel)
    }
    
    func clothDidTap(with index: IndexPath) {
        // [art] Open new screen view cloth
        router.goToAboutCloth(presenter: self)
    }
}

extension ClothesListPresenter: ClothesListInteractorOutput {
    func clothDidLoad(with array: [ClothesSection]) {
        data = array
        
        // Копирование ответа интерактора в локальный массив
        tableData = array.map {
            let sectionTitle = $0.title
            let sectionRows = $0.rows
            return ClothesSectionPresenter.init(title: sectionTitle, clothers: sectionRows)
        }
        
        view?.reloadData()
    }
}
