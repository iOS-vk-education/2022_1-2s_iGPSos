//
//  HomeProtocols.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import Foundation

protocol HomeModuleInput: AnyObject {
    var moduleOutput: HomeModuleOutput? { get }
    func updateAfterCreating()
}

protocol HomeModuleOutput: AnyObject {
}

protocol HomeViewInput: AnyObject {
    func update(with state: ControllerState)
    func updateEvents(with array: [CalendarEvent])
}

protocol HomeViewOutput: AnyObject {
    var lookList: [HomeSection] { get }
    func viewDidLoad()
    func reloadData()
    func dateDidChange(with date: Date)
    func clothDidTap(with index: IndexPath)
    func configureCalendarTitle(date: Date) -> (String, String)
    func addButtonDidTaped()
}

protocol HomeInteractorInput: AnyObject {
    func fetchEvents()
    func fetchCurrentEvents(date: Date)
}

protocol HomeInteractorOutput: AnyObject {
    func eventsDidRecive(with array: [CalendarEvent])
    func currentEventsDidRecive(with array: [HomeSection])
}

protocol HomeRouterInput: AnyObject {
    func goToCreateMeeting(presenter: HomeModuleInput)
}
