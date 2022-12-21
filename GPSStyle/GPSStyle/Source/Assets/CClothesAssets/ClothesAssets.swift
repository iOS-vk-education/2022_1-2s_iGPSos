//
//  ClothesAssets.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 19.11.2022.
//

struct pickerViewUnitCreateClothes {
    let name: String
    let variants: [String]
}

internal let clothesBrand = ["Gucci",
                      "Prada",
                      "Ostin",
                      "Lacoste",
                      "Louis Vuitton",
                      "Giorgio Armani",
                      "Polo Ralph Lauren",
                      "другой"]

internal let clothesColor = ["Белый",
                      "Красный",
                      "Оранжевый",
                      "Жёлтый",
                      "Залёный",
                      "Голубой",
                      "Синий",
                      "Фиолетовый",
                      "Розовый",
                      "Бирюзовый",
                      "Охра",
                      "Чёрный",
                      "другой"]

internal let clothesSize = ["S",
                     "M",
                     "L",
                     "XL",
                     "XXL",
                     "XXXL",
                     "4XL",
                     "другой"]

internal let pickerUnitClothesBrand = pickerViewUnitCreateClothes(name: "Brand", variants: clothesBrand)
internal let pickerUnitClothesColor = pickerViewUnitCreateClothes(name: "Color", variants: clothesColor)
internal let pickerUnitClothesSize = pickerViewUnitCreateClothes(name: "Size", variants: clothesSize)
