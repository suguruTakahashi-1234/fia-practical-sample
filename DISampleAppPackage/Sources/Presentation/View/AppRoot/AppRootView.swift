//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import SwiftUI

@MainActor
public struct AppRootView<Router: AppRootWireframe, Dependency: AppRootPresenterDependency>: View {
    private let router: Router
    @StateObject private var presenter: AppRootPresenter<Dependency>

    public init(router: Router, dependency: Dependency) {
        self.router = router
        _presenter = .init(wrappedValue: AppRootPresenter(dependency: dependency))
    }

    public var body: some View {
        Group {
            if presenter.isCompletedOnboarding {
                router.createHomeTabView()
            } else {
                router.createOnboardingView()
            }
        }
        .task {
            await presenter.onAppear()
        }
        .onDisappear {
            presenter.onDisappear()
        }
    }
}

import PreviewSnapshots

struct AppRootView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.fixedSize(horizontal: false, vertical: false)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        PreviewSnapshots(
            configurations: standard,
            configure: { state in
                AppRootView(router: AppRootRouter.empty, dependency: state)
            }
        )
    }
}
