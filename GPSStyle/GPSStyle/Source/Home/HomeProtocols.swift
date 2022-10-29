//
//  HomeProtocols.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import Foundation

enum HomeState {
    case isLoading
    case empty
    case success
    case faild
}

protocol HomeModuleInput {
    var moduleOutput: HomeModuleOutput? { get }
}

protocol HomeModuleOutput: AnyObject {
}

protocol HomeViewInput: AnyObject {
    func update(with state: HomeState)
}

protocol HomeViewOutput: AnyObject {
    var lookList: [HomeSection] { get }
    func viewDidLoad()
    func dateDidChange(new date: Date)
    func addButtonDidTap()
    func clothDidTap(with index: IndexPath)
}

protocol HomeInteractorInput: AnyObject {
}

protocol HomeInteractorOutput: AnyObject {
}

protocol HomeRouterInput: AnyObject {
}
