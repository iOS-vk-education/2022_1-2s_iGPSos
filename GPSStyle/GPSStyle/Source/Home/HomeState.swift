//
//  HomeState.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 01.11.2022.
//

import Foundation

struct HomeState {
    enum State {
        case isLoading
        case empty
        case success
        case faild
    }

    var getErrorTitle: String?
    var shouldShowErrorLabel: Bool = false
    var shouldShowErrorButton: Bool = false
    var isLoading: Bool = false
    var isFinished: Bool = false

    init(state: HomeState.State) {
        switch state {
        case .empty:
            getErrorTitle = L10n.emptyHomeTitle
            shouldShowErrorLabel = true
            shouldShowErrorButton = false
            isLoading = false
            isFinished = false
        case .faild:
            getErrorTitle = L10n.errorHomeTitle
            shouldShowErrorLabel = true
            shouldShowErrorButton = true
            isLoading = false
            isFinished = false
        case .success:
            getErrorTitle = nil
            shouldShowErrorLabel = false
            shouldShowErrorButton = false
            isLoading = false
            isFinished = true
        case .isLoading:
            getErrorTitle = nil
            shouldShowErrorLabel = false
            shouldShowErrorButton = false
            isLoading = true
            isFinished = false
        }
    }
}
