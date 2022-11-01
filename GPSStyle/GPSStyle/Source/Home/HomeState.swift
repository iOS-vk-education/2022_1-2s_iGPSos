//
//  HomeState.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 01.11.2022.
//

import Foundation

final class HomeState {
    enum State {
        case isLoading
        case empty
        case success
        case faild
    }

    private var state: State?
    private var reloadData: (() -> Void)?
    private var startAnimation: (() -> Void)?
    private var stopAnimation: (() -> Void)?
    
    var shouldShowErrorLabel: Bool {
        switch state {
        case .isLoading:
            return false
        case .empty:
            return true
        case .success:
            return false
        case .faild:
            return true
        case .none:
            return false
        }
    }
    
    var shouldShowErrorButton: Bool {
        switch state {
        case .isLoading:
            return false
        case .empty:
            return false
        case .success:
            return false
        case .faild:
            return true
        case .none:
            return false
        }
    }
    
    var getErrorTitle: String? {
        switch state {
        case .isLoading:
            return nil
        case .empty:
            return L10n.emptyHomeTitle
        case .success:
            return nil
        case .faild:
            return L10n.errorHomeTitle
        case .none:
            return nil
        }
    }
    
    init(
        reloadData: (() -> Void)?,
        startAnimation: (() -> Void)?,
        stopAnimation: (() -> Void)?
    ) {
        self.reloadData = reloadData
        self.startAnimation = startAnimation
        self.stopAnimation = stopAnimation
    }

    func setNewState(_ state: HomeState.State) {
        self.state = state
    }
    
    func reloadIfNeeded() {
        if state == .success {
            reloadData?()
        }
    }
    
    func updateAnimation() {
        switch state {
        case .isLoading:
            startAnimation?()
        case .empty:
            stopAnimation?()
        case .success:
            stopAnimation?()
        case .faild:
            stopAnimation?()
        case .none:
            stopAnimation?()
        }
    }
}
