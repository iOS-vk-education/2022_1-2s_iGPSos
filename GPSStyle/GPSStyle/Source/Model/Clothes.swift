//
//  Clothes.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 10.12.2022.
//

import Foundation

struct Clothes {
    let uuid: String
    let userid: String // uuid
    let name: String
    let imageName: String
    let brand: String?
    let size: String?
    let color: String?
    let checkWeather: Bool
}

struct Look {
    let clothes: [String] // id uuid Clothes
    let userid: String // uuid
}

struct Meeting {
    let date: String // date and time
    let lookid: String
    let userid: String
    let repeatEveryWeek: Bool
}
