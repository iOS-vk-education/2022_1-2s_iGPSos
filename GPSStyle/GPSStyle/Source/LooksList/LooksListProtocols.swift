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
}

protocol LooksListViewOutput: AnyObject {
}

protocol LooksListInteractorInput: AnyObject {
}

protocol LooksListInteractorOutput: AnyObject {
}

protocol LooksListRouterInput: AnyObject {
}
