// Generated using Sourcery 2.1.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// TODO: update file header

import Foundation
import DomainLayer

@MainActor
final class SettingPresenter: ObservableObject {

    init(dependency: some SettingPresenterDependency) {
        LoggerContainer.initLog()
    }

    deinit {
        LoggerContainer.deinitLog()
    }

    func onAppear() {
        LoggerContainer.logOnAppear()
    }

    func onDisappear() {
        LoggerContainer.logOnDisappear()
    }
}
