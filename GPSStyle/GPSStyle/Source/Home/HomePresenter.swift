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
    ] // MOCK DATA

    init(router: HomeRouterInput, interactor: HomeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomeModuleInput {
}

extension HomePresenter: HomeViewOutput {
    func addButtonDidTaped() {
        router.goToCreateMeeting()
    }
    
    func reloadData() {
        // [art] reload data
    }
    
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
    
    func dateDidChange(with date: Date) {
        view?.update(with: ControllerState(state: .isLoading, config: homeConfig))
        interactor.fetchCurrentEvents(date: date)
    }
    
    var lookList: [HomeSection] {
        return data
    }
    
    func viewDidLoad() {
        view?.update(with: ControllerState(state: .isLoading, config: homeConfig))
        interactor.fetchEvents()
    }
}

extension HomePresenter: HomeInteractorOutput {
    func currentEventsDidRecive(with array: [HomeSection]) {
        data = array
        if data.isEmpty {
            view?.update(with: ControllerState(state: .empty, config: homeConfig))
            return
        }
        view?.update(with: ControllerState(state: .success, config: homeConfig))
    }
    
    func eventsDidRecive(with array: [CalendarEvent]) {
        view?.updateEvents(with: array)
    }
}
