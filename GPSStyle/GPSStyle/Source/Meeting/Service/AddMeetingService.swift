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
        lookId: String
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
        lookId: String
    ) {
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
