//
//  ControllerState.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 01.11.2022.
//

import Foundation

struct StateConfig {
    let emptyTitle: String
    let errorTitle: String
}

let homeConfig = StateConfig(emptyTitle: L10n.emptyHomeTitle, errorTitle: L10n.errorTitle)
let lookConfig = StateConfig(emptyTitle: L10n.emptyLookTitle, errorTitle: L10n.errorTitle)

struct ControllerState {
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
    var isEmpty: Bool = false

    init(state: ControllerState.State, config: StateConfig) {
        switch state {
        case .empty:
            getErrorTitle = config.emptyTitle
            shouldShowErrorLabel = true
            shouldShowErrorButton = false
            isLoading = false
            isFinished = false
            isEmpty = true
        case .faild:
            getErrorTitle = config.errorTitle
            shouldShowErrorLabel = true
            shouldShowErrorButton = true
            isLoading = false
            isFinished = false
            isEmpty = false
        case .success:
            getErrorTitle = nil
            shouldShowErrorLabel = false
            shouldShowErrorButton = false
            isLoading = false
            isFinished = true
            isEmpty = false
        case .isLoading:
            getErrorTitle = nil
            shouldShowErrorLabel = false
            shouldShowErrorButton = false
            isLoading = true
            isFinished = false
            isEmpty = false
        }
    }
}
