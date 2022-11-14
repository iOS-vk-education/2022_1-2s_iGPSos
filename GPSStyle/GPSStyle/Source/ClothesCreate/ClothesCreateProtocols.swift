//
//  ClothesCreateProtocols.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 29.10.2022.
//

import Foundation

protocol ClothesCreateModuleInput {
    var moduleOutput: ClothesCreateModuleOutput? { get }
}

protocol ClothesCreateModuleOutput: AnyObject {
}

protocol ClothesCreateViewInput: AnyObject {
}

protocol ClothesCreateViewOutput: AnyObject {
    func didTapCreateClothes()
}

protocol ClothesCreateInteractorInput: AnyObject {
}

protocol ClothesCreateInteractorOutput: AnyObject {
}

protocol ClothesCreateRouterInput: AnyObject {
    func goToMainScreen()
}
