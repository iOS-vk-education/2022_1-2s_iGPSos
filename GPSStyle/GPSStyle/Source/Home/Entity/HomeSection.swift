//
//  HomeSection.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 29.10.2022.
//

import Foundation

struct HomeSection {
    var title: String
    let rows: [HomeRow]
}

struct HomeRow: Hashable {
    let id: String
    let title: String
    let imageUrl: String
    let isWarning: Bool
    let specification: [Specification]
    
    var stringSpecification: String {
        specification.reduce("", { partialResult, specification in
            partialResult + specification.type + ": " + specification.value + " "
        })
    }
}

struct Specification: Hashable {
    let type: String
    let value: String
}
