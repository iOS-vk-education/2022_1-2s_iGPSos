//
//  ClothesAssets.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 19.11.2022.
//

enum TypeName: String {
    case brand = "Brand"
    case color = "Color"
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

internal let clothesColor = ["Белый",
                      "Красный",
                      "Оранжевый",
                      "Жёлтый",
                      "Зелёный",
                      "Голубой",
                      "Синий",
                      "Фиолетовый",
                      "Розовый",
                      "Бирюзовый",
                      "Охра",
                      "Cерый",
                      "Коричневый",
                      "Чёрный",
                      "другой"]

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
