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
    let typeName: String
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

internal let pickerUnitClothesBrand = UnitClothesType(name: L10n.brand,
                                                      variants: clothesBrand,
                                                      typeName: TypeName.brand.rawValue)
internal let pickerUnitClothesColor = UnitClothesType(name: L10n.color,
                                                      variants: clothesColor,
                                                      typeName: TypeName.color.rawValue)
internal let pickerUnitClothesSize = UnitClothesType(name: L10n.size,
                                                     variants: clothesSize,
                                                     typeName: TypeName.size.rawValue)
