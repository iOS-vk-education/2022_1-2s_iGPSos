//
//  HomeProtocols.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import Foundation

protocol HomeModuleInput {
    var moduleOutput: HomeModuleOutput? { get }
}

protocol HomeModuleOutput: AnyObject {
}

protocol HomeViewInput: AnyObject {
}

protocol HomeViewOutput: AnyObject {
}

protocol HomeInteractorInput: AnyObject {
}

protocol HomeInteractorOutput: AnyObject {
}

protocol HomeRouterInput: AnyObject {
}
