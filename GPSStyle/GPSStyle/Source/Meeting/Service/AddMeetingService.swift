//
//  AddMeetingService.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 24.12.2022.
//

import Firebase

protocol AddMeetingServiceInput: AnyObject {
    func createMeeting(
        date: Date,
        title: String,
        lookId: String,
        repeatEveryWeek: Bool
    )
}

protocol AddMeetingServiceOutput: AnyObject {
    func faild()
    func success()
}

final class AddMeetingService {
    private let database = Firestore.firestore()
    weak var output: AddMeetingServiceOutput?
    
    init(interactor: AddMeetingServiceOutput?) {
        output = interactor
    }
}

extension AddMeetingService: AddMeetingServiceInput {
    func createMeeting(
        date: Date,
        title: String,
        lookId: String,
        repeatEveryWeek: Bool
    ) {
        if repeatEveryWeek {
            for i in 0..<4 {
                var dict = [String: Any]()
                
                let repeatedDate = Calendar.current.date(byAdding: .day, value: i * 7, to: date)
                
                dict["date"] = repeatedDate
                dict["title"] = title
                dict["uuid"] = UUID().uuidString
                dict["userId"] = Auth.auth().currentUser?.uid
                dict["looksId"] = lookId
                database.collection("meeting").addDocument(data: dict) { [weak self] error in
                    if error != nil {
                        self?.output?.faild()
                    } else {
                        self?.output?.success()
                    }
                }
            }
        } else {
            var dict = [String: Any]()
            
            dict["date"] = date
            dict["title"] = title
            dict["uuid"] = UUID().uuidString
            dict["userId"] = Auth.auth().currentUser?.uid
            dict["looksId"] = lookId
            database.collection("meeting").addDocument(data: dict) { [weak self] error in
                if error != nil {
                    self?.output?.faild()
                } else {
                    self?.output?.success()
                }
            }
        }
    }
}
