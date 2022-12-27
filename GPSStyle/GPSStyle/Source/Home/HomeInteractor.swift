//
//  HomeInteractor.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import Foundation

final class HomeInteractor {
    weak var output: HomeInteractorOutput?
    var eventsService: CalendarEventServiceInput?
    var daysEventsService: DaysEventsServiceInput?
    
    init() {
        eventsService = CalendarEventService(interactor: self)
        daysEventsService = DaysEventsService(interactor: self)
    }
}

extension HomeInteractor: HomeInteractorInput {
    func fetchCurrentEvents(date: Date) {
        daysEventsService?.fetchDaysEvents(selectedDate: date)
    }
    
    func fetchEvents() {
        eventsService?.fetchEvents()
    }
}

extension HomeInteractor: CalendarEventServiceOutput {
    func faild() {
    }
    
    func success(with array: [CalendarEvent]) {
        output?.eventsDidRecive(with: array)
    }
}
extension HomeInteractor: DaysEventsServiceOutput {
   func reciveEvents(array: [HomeSection]) {
       output?.currentEventsDidRecive(with: array)
   }
}
