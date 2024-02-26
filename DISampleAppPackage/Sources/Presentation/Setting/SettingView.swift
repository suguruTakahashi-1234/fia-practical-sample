//
//  Created by sugurutakahashi on 2024/02/22
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import DomainLayer

public protocol SettingWireframe {}

public protocol SettingPresenterDependency {}

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

public struct SettingView: View {
    private let router: SettingWireframe
    @StateObject private var presenter: SettingPresenter

    public init(router: some SettingWireframe, dependency: some SettingPresenterDependency) {
        self.router = router
        _presenter = .init(wrappedValue: .init(dependency: dependency))
    }
    
    public var body: some View {
        Text("SettingView")
            .task {
                presenter.onAppear()
            }
            .onDisappear {
                presenter.onDisappear()
            }
    }
}

// MARK: - Preview

import PreviewSnapshots

struct SettingView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependency> {
        .init(
            configurations: [],
            configure: { state in
                // TODO: add SettingPresenterDependency to AppRootRouterDependency
                SettingView(router: AppRootRouter.empty, dependency: state)
            }
        )
    }
}
