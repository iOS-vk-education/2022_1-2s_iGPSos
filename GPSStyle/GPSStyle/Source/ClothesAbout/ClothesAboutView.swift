//
//  ClothesAboutView.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 06.05.2023.
//

import SwiftUI

struct ClothesAboutView: View {
    @ObservedObject var viewModel: ClothesAboutViewModel
    
    var body: some View {
            VStack {
                Spacer()
                ZStack {
                    Spacer()
                        .frame(width: 150.0, height: 250.0)
//                        .foregroundColor(Color.lightGray)
                        .cornerRadius(42)
                        .shadow(radius: 5)
                }
            }
    }
}
