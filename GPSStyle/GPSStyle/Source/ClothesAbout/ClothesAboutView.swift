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
            Spacer(minLength: 50)
            ImageClothesView()
            HStack(spacing: 10) {
                SpecificationClothesView(title: "Туфли")
                SpecificationClothesView(title: "39 EU")
                SpecificationClothesView(title: "Обувь")
                SpecificationClothesView(title: "Gucci")
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            ButtonEditClothesView()
            Spacer()
        }
    }
}

struct SpecificationClothesView: View {
    var title: String
    
    var body: some View {
        VStack {
            Text(title)
                .foregroundColor(.black)
                .frame(width: 60, height: 60)
                .background(SwiftUI.Color.white)
                .cornerRadius(14)
                .shadow(radius: 5)
        }
    }
}

struct ImageClothesView: View {
    var body: some View {
        VStack {
            Image("shoes")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 194, height: 194)
                .background(SwiftUI.Color.white)
                .cornerRadius(24)
                .shadow(radius: 5)
        }
    }
}

struct ButtonEditClothesView: View {
    var body: some View {
        VStack {
            Text("Изменить")
                .foregroundColor(.white)
                .font(.system(size: 22))
//            titleLabel?.font = FontFamily.Inter.medium.font(size: 22)
                .frame(width: 265, height: 65)
                .background(SwiftUI.Color(red: 0.6730021834, green: 0.4277178049, blue: 0.6891061068))
                .cornerRadius(48)
            Spacer()
        }
    }
}
