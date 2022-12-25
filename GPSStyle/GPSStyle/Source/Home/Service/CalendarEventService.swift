//
//  CalendarEventService.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 24.11.2021.
//

import Firebase

protocol CalendarEventServiceInput: AnyObject {
    func fetchEvents()
}

protocol CalendarEventServiceOutput: AnyObject {
    func faild()
    func success(with array: [CalendarEvent])
}

final class CalendarEventService {
    private let database = Firestore.firestore()
    weak var output: CalendarEventServiceOutput?
    
    init(interactor: CalendarEventServiceOutput?) {
        output = interactor
    }
}

extension CalendarEventService: CalendarEventServiceInput {
    func fetchEvents() {
        database.collection("meeting").whereField(
            "userId", isEqualTo: Auth.auth().currentUser?.uid ?? ""
        ).getDocuments { [weak self] querySnapshot, error in
            if error != nil {
                self?.output?.faild()
                return
            }
            guard let documents = querySnapshot?.documents else {
                self?.output?.faild()
                return
            }
            
            let events = documents.map { snapshot -> CalendarEvent? in
                let data = snapshot.data()
                guard let date = data["date"] as? Timestamp else {
                    return nil
                }
                return CalendarEvent(
                    title: "",
                    startDate: date.dateValue(),
                    endDate: date.dateValue()
                )
            }.compactMap { $0 }
            self?.output?.success(with: events)
        }
    }
}
