//
//  ClothesModel.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 24.12.2022.
//

import Foundation

struct ClothingModel: Hashable {
    let uuid: String
    let name: String
    let imageName: String
    let specification: SpecificationModel
}
