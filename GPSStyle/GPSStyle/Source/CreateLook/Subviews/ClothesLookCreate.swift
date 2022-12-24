//
//  ClothesLookCreate.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 10.12.2022.
//

import Foundation

struct ClothesLookCreate: Hashable {
    var isSelected: Bool
    let uuid: String
    let name: String
    let imageName: String
    let specification: [Specification]
    
    var stringSpecification: String {
        specification.reduce("", { partialResult, specification in
            partialResult + specification.type + ": " + specification.value + " "
        })
    }
}
