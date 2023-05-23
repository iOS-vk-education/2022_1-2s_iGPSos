//
//  ClothesAboutViewModel.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 06.05.2023.
//

import Foundation
import SwiftUI

final class ClothesAboutViewModel: ObservableObject {
    @Published var clothingModel: ClothingModel
    
    init(clothingModel: ClothingModel) {
        self.clothingModel = clothingModel
    }
    
    func getImage() -> Image {
        let cash = ImageCache()
        if let image = cash.image(for: clothingModel.imageName) {
            return Image(uiImage: image)
        } else {
            return Image(systemName: "load")
        }
    }
}
