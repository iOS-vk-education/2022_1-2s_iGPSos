//
//  DaysEventsService.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 25.12.2022.
//

import Firebase

protocol DaysEventsServiceInput: AnyObject {
    func fetchDaysEvents(selectedDate: Date)
}

protocol DaysEventsServiceOutput: AnyObject {
    func reciveEvents(array: [HomeSection])
}

final class DaysEventsService {
    private let database = Firestore.firestore()
    weak var output: DaysEventsServiceOutput?
    
    init(interactor: DaysEventsServiceOutput?) {
        output = interactor
    }
}

extension DaysEventsService: DaysEventsServiceInput {
    func fetchDaysEvents(selectedDate: Date) {
        var sections = [HomeSection]()
        database.collection("meeting").whereField(
            "userId", isEqualTo: Auth.auth().currentUser?.uid ?? ""
        ).getDocuments { [weak self] querySnapshot, error in
            if error != nil {
                return
            }
            guard let documents = querySnapshot?.documents else {
                return
            }
            
            let selectedEvents = documents.filter { snapshot in
                let data = snapshot.data()
                guard let date = data["date"] as? Timestamp else {
                    return false
                }
                return Calendar.current.isDate(date.dateValue(), equalTo: selectedDate, toGranularity: .day)
            }.compactMap { snapshot -> (String?, String?)? in
                let data = snapshot.data()
                guard let uuid = data["looksId"] as? String, let title = data["title"] as? String else {
                    return nil
                }
                return (uuid, title)
            }
            if selectedEvents.isEmpty {
                self?.output?.reciveEvents(array: [])
                return
            }

            self?.database.collection("looks").whereField(
                "userId", isEqualTo: Auth.auth().currentUser?.uid ?? ""
            ).whereField(
                "uuid", in: selectedEvents.map({ tuple in
                    tuple.0 as Any
                })
            ).getDocuments { querySnapshot, error in
                if error != nil {
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    return
                }
                let clothsId = documents.compactMap { snapshot -> [String]? in
                    let data = snapshot.data()
                    guard let clothId = data["clothId"] as? [String] else {
                        return nil
                    }
                    return clothId
                }
                
                let group = DispatchGroup()
                for (index, clothId) in clothsId.enumerated() {
                    group.enter()
                    self?.database.collection("clothes").whereField(
                        "userId", isEqualTo: Auth.auth().currentUser?.uid ?? ""
                    ).whereField(
                        "uuid", in: clothId
                    ).getDocuments { querySnapshot, error in
                        if error != nil {
                            return
                        }
                        guard let documents = querySnapshot?.documents else {
                            return
                        }
                        let homeRow = documents.compactMap { snapshot -> HomeRow? in
                            let data = snapshot.data()
                            var specifications = [Specification]()
                            guard let specificationsDict = data["specification"] as? NSMutableDictionary  else { return nil }
                           
                            for d in specificationsDict {
                                specifications.append(
                                    Specification(
                                        type: d.key as? String ?? "",
                                        value: d.value as? String ?? ""
                                    )
                                )
                            }
                            
                            return HomeRow(
                                id: data["uuid"] as? String ?? "",
                                title: data["name"] as? String ?? "",
                                imageUrl: data["imageName"] as? String ?? "",
                                isWarning: false,
                                specification: specifications
                            )
                        }
                        sections.append(HomeSection(title: selectedEvents[index].1 ?? "", rows: homeRow))
                        group.leave()
                    }
                }
                group.notify(queue: .main) { [weak self] in
                    self?.output?.reciveEvents(array: sections)
                }
            }
        }
    }
}
