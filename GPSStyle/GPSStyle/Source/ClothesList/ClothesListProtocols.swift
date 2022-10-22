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
}

protocol ClothesListViewOutput: AnyObject {
}

protocol ClothesListInteractorInput: AnyObject {
}

protocol ClothesListInteractorOutput: AnyObject {
}

protocol ClothesListRouterInput: AnyObject {
}
