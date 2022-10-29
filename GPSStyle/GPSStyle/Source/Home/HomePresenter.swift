//
//  HomePresenter.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import Foundation

final class HomePresenter {
    weak var view: HomeViewInput?
    weak var moduleOutput: HomeModuleOutput?
    
    private let router: HomeRouterInput
    private let interactor: HomeInteractorInput
    private var data: [HomeSection] = [
        .init(title: "На встречу в 14:30", rows: [
            .init(
                id: 1,
                title: "Штаны хлопковые",
                imageUrl: "1645850968_1-krasavica-info-p-belie-tufli-na-belom-fone-devushka-krasivo-1.jpg",
                isWarning: true,
                specification: [
                    .init(type: "Цвет", value: "Черный")
                ]),
            .init(
                id: 2,
                title: "Штаны хлопковые",
                imageUrl: "black-women-s-shoes-isolated-on-white-background-3d-rendering-illustration_97167-287.jpg.webp",
                isWarning: true,
                specification: [
                    .init(type: "Цвет", value: "Черный")
                ]),
            .init(
                id: 3,
                title: "Штаны хлопковые",
                imageUrl: "empty_10.jpg",
                isWarning: true,
                specification: [
                    .init(type: "Цвет", value: "Черный")
                ]),
            .init(
                id: 4,
                title: "Штаны хлопковые",
                imageUrl: "1645850968_1-krasavica-info-p-belie-tufli-na-belom-fone-devushka-krasivo-1.jpg",
                isWarning: true,
                specification: [
                    .init(type: "Цвет", value: "Черный")
                ]),
            .init(
                id: 5,
                title: "Штаны хлопковые",
                imageUrl: "black-women-s-shoes-isolated-on-white-background-3d-rendering-illustration_97167-287.jpg.webp",
                isWarning: true,
                specification: [
                    .init(type: "Цвет", value: "Черный")
                ]),
            .init(
                id: 6,
                title: "Штаны хлопковые",
                imageUrl: "empty_10.jpg",
                isWarning: true,
                specification: [
                    .init(type: "Цвет", value: "Черный")
                ]),
            .init(
                id: 7,
                title: "Штаны хлопковые",
                imageUrl: "1645850968_1-krasavica-info-p-belie-tufli-na-belom-fone-devushka-krasivo-1.jpg",
                isWarning: true,
                specification: [
                    .init(type: "Цвет", value: "Черный")
                ]),
            .init(
                id: 8,
                title: "Штаны хлопковые",
                imageUrl: "black-women-s-shoes-isolated-on-white-background-3d-rendering-illustration_97167-287.jpg.webp",
                isWarning: true,
                specification: [
                    .init(type: "Цвет", value: "Черный")
                ]),
            .init(
                id: 9,
                title: "Штаны хлопковые",
                imageUrl: "empty_10.jpg",
                isWarning: true,
                specification: [
                    .init(type: "Цвет", value: "Черный")
                ])
        ]
        )
    ] // MOCK DATA

    init(router: HomeRouterInput, interactor: HomeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomeModuleInput {
}

extension HomePresenter: HomeViewOutput {
    func configureCalendarTitle(date: Date) -> (String, String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        formatter.dateFormat = "MMM"
        let month = formatter.string(from: date)
        return (month, year)
    }
    
    func addButtonDidTap() {
        // [art] Open new screen add event
    }
    
    func clothDidTap(with index: IndexPath) {
        // [art] Open new screen view cloth
    }
    
    func dateDidChange(new date: Date) {
        view?.update(with: .isLoading)
        // [art] update data
        view?.update(with: .success)
    }
    
    var lookList: [HomeSection] {
        return data
    }
    
    func viewDidLoad() {
        view?.update(with: .success)
    }
}

extension HomePresenter: HomeInteractorOutput {
}
