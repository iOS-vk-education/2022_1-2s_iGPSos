//
//  ClothesCreateProtocols.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 29.10.2022.
//

import Foundation
import UIKit

protocol ClothesCreateModuleInput {
    var moduleOutput: ClothesCreateModuleOutput? { get }
}

protocol ClothesCreateModuleOutput: AnyObject {
}

protocol ClothesCreateViewInput: AnyObject {
    func configure(with model: ClothesRow?)
}

protocol ClothesCreateViewOutput: AnyObject {
    func didLoadView()
    func didTapCreateClothes(model: ClothesModel)
}

protocol ClothesCreateInteractorInput: AnyObject {
    func createClothes(model: ClothesModel)
}

protocol ClothesCreateInteractorOutput: AnyObject {
    func finishCreatingCloth()
}

protocol ClothesCreateRouterInput: AnyObject {
    func closeVC()
}

struct ClothesModel {
    let title: String
    let image: UIImage
    let checkWeather: Bool
    let specification: SpecificationModel
}
