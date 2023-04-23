//
//  ClothesSection.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 21.04.2023.
//

import Foundation

struct ClothesSection {
    let title: String
    let rows: [ClothesRow]
}

struct ClothesRow: Hashable {
    let id: String
    let title: String
    let imageUrl: String
    let isWarning: Bool
    let specification: SpecificationModel
    
    var stringSpecification: String {
        return "Размер:  \(specification.size) Брэнд: \(specification.brand)"
        
//        specification.reduce("", { partialResult, specification in
//            partialResult + specification.type + ": " + specification.value + " "
//        })
    }
}

struct SpecificationModel: Hashable {
    var brand: String
    var category: String
    var size: String
}
