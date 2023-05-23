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
    
//    private var data: [ClothesSection] = []
    private var tableData: [ClothesSection] = []
    private var searchTable: [ClothesSectionSearch] = []
    private var lastSearchText: String?
    
    init(router: ClothesListRouterInput, interactor: ClothesListInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    func textMatch(inCell element: ClothesRow, withText compare: String) -> Bool {
        let lowCasedCompare = compare.lowercased()
        let elementTitle = element.title.lowercased()
        let elementBrand = element.specification.brand.lowercased()
        return elementTitle.hasPrefix(lowCasedCompare) ||
               elementBrand.hasPrefix(lowCasedCompare)
    }
}

extension ClothesListPresenter: ClothesListModuleInput {
}

extension ClothesListPresenter: ClothesListViewOutput {
    func viewWillAppear() {
        interactor.fetchClothing()
    }
    
    func addButtonDidTap() {
        router.goToAddClothesScreen()
    }
    
    // Получение названия секции
    func getTitle(for section: Int) -> String {
        guard lastSearchText == nil else {
            return searchTable[section].title
        }
        return tableData[section].title
    }
    
    // Получение информации для конкретной ячейки
    func getCell(at index: IndexPath) -> ClothesRow {
        guard lastSearchText == nil else {
            return searchTable[index.section].clothers[index.row]
        }
        return tableData[index.section].rows[index.row]
    }
    
    func getSectionCount() -> Int {
        guard lastSearchText == nil else {
            return searchTable.count
        }
        return tableData.count
    }
    
    // Получение числа ячеек в секции
    func getCellCount(in section: Int) -> Int {
        guard lastSearchText == nil else {
            return searchTable[section].clothers.count
        }
        return tableData[section].rows.count
    }
    
    // Удаление конкретной ячейки
    func removeCell(at index: IndexPath) {
        // Удаление из состояния поиска
        var tableIndex = index
        if lastSearchText != nil {
            tableIndex = IndexPath(row: searchTable[index.section].clothersIndex[index.row],
                                   section: searchTable[index.section].sectionIndex)
            searchTable[index.section].clothers.remove(at: index.row)
            if searchTable[index.section].clothers.count == 0 {
                searchTable.remove(at: index.section)
            }
        }
        // Создание модели одежды для передачи интерактору
        let clothCell = tableData[tableIndex.section].rows[tableIndex.row]
        let clothId = clothCell.id
        let clothTitle = clothCell.title
        let clothImage = clothCell.imageUrl
        let clothSpec = clothCell.specification
        let clothModel = ClothingModel(uuid: clothId, name: clothTitle, imageName: clothImage, specification: clothSpec)
        
        // Удаление из локального массива
        tableData[tableIndex.section].rows.remove(at: tableIndex.row)
        
        // Проверка на отстутсвие секции
        if tableData[tableIndex.section].rows.count == 0 {
            tableData.remove(at: tableIndex.section)
        }
        
        interactor.deleteClthClothing(for: clothModel)
        
        // Перерисовка таблицы
        view?.reloadData()
    }
    
    func endSearch() {
        lastSearchText = nil
        searchTable.removeAll(keepingCapacity: true)
        view?.hideNoResult()
    }
    
    func updateSearchResult(text searchText: String) {
        // Очистка предыдущих результатов
        searchTable.removeAll(keepingCapacity: true)
        
        // Цикл поиска
        lastSearchText = searchText
        for (sectionIndex, sectionElement) in tableData.enumerated() {
            // Предварительно сохраняем элементы исследуемой категории
            let searchSectionTitle = sectionElement.title
            
            // Логика поиска
            if sectionElement.title.lowercased().hasPrefix(searchText.lowercased()) {
                /* Если введена часть названия категории
                 * Добавляем всю категорию в результат поиска */
                let searchSectionClothers = sectionElement.rows
                let searchSectionCapacity = searchSectionClothers.count
                
                let searchSection = ClothesSectionSearch(title: searchSectionTitle,
                                                         clothers: searchSectionClothers,
                                                         sectionIndex: sectionIndex,
                                                         clothersIndex: Array(0..<searchSectionCapacity))
                searchTable.append(searchSection)
            } else {
                /* Если введена часть наименования одежды для других категорий
                 * Добавляем только те категории, в которых есть хотя бы одна найденная вещь */
                
                // Выборка одежды
                var searchSectionCloth: [ClothesRow] = []
                var searchSectionClothIndexes: [Int] = []
                for (cellIndex, cellElement) in sectionElement.rows.enumerated()
                where textMatch(inCell: cellElement, withText: searchText) {
                    searchSectionCloth.append(cellElement)
                    searchSectionClothIndexes.append(cellIndex)
                }
                
                // Вычисление числа элементов в выборке и добавление в конечный список
                if searchSectionCloth.count != 0 {
                    let searchSection = ClothesSectionSearch(title: searchSectionTitle,
                                                             clothers: searchSectionCloth,
                                                             sectionIndex: sectionIndex,
                                                             clothersIndex: searchSectionClothIndexes)
                    searchTable.append(searchSection)
                }
            }
        }
        
        // Проверка на наличие результата
        if searchTable.count == 0 {
            view?.showNoResult()
        } else {
            view?.hideNoResult()
        }
        
        // Запрос на перерисовку таблицы
        view?.reloadData()
    }
    
    func clothDidTap(with index: IndexPath) {
        // [art] Open new screen view cloth

        var tableIndex = index
        if lastSearchText != nil {
            tableIndex = IndexPath(row: searchTable[index.section].clothersIndex[index.row],
                                   section: searchTable[index.section].sectionIndex)
            searchTable[index.section].clothers.remove(at: index.row)
            if searchTable[index.section].clothers.count == 0 {
                searchTable.remove(at: index.section)
            }
        }
        // Создание модели одежды для передачи интерактору
        let clothCell = tableData[tableIndex.section].rows[tableIndex.row]
        let clothId = clothCell.id
        let clothTitle = clothCell.title
        let clothImage = clothCell.imageUrl
        let clothSpec = clothCell.specification
        let clothModel = ClothingModel(uuid: clothId, name: clothTitle, imageName: clothImage, specification: clothSpec)
        
        router.goToAboutCloth(model: clothModel)
    }
}

extension ClothesListPresenter: ClothesListInteractorOutput {
    func clothDidLoad(with array: [ClothesSection]) {
        tableData = array
        
        // Запрос на перерасчет поиска (Если мы в режиме поиска)
        if let text = lastSearchText {
            updateSearchResult(text: text)
        }
        
        view?.reloadData()
    }
}
