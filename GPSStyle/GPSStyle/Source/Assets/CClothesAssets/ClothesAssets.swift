//
//  ClothesAssets.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 19.11.2022.
//

enum TypeName: String {
    case brand = "Brand"
    case category = "Category"
    case size = "Size"
}

struct UnitClothesType {
    let name: String
    let variants: [String]
    let typeName: TypeName
    let selectedValue: String?
}

internal let clothesBrand = ["Gucci",
                      "Prada",
                      "Ostin",
                      "Lacoste",
                      "Louis Vuitton",
                      "Giorgio Armani",
                      "Polo Ralph Lauren",
                      "Nike",
                      "Adidas",
                      "другой"]

internal let clothesCategory = ["Верхняя одежда",
                                "Штаны",
                                "Обувь",
                                "Кофты",
                                "Свитера",
                                "Футболки",
                                "Платья",
                                "Юбки",
                                "Шорты",
                                "Рубашки",
                                "Блузки",
                                "Пиджаки",
                                "Костюмы",
                                "Аксессуары",
                                "Другое"]

internal let clothesSize = ["S",
                     "M",
                     "L",
                     "XL",
                     "XXL",
                     "XXXL",
                     "4XL",
                     "37EU",
                     "38EU",
                     "39EU",
                     "40EU",
                     "45EU",
                     "другой"]
