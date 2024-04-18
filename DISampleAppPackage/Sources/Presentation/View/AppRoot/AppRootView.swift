//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct AppRootView<Dependency: AppRootRouterDependency>: View {
    private let router: AppRootRouter<Dependency>
    @State private var presenter: AppRootPresenter<Dependency>

    public init(router: AppRootRouter<Dependency>) {
        self.router = router
        presenter = AppRootPresenter(dependency: router.dependency)
    }

    public var body: some View {
        Group {
            if presenter.isCompletedOnboarding {
                HomeTabView(router: router)
            } else {
                OnboardingView(router: router)
                    .navigationStacked()
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

// MARK: - Preview

import PreviewSnapshots

struct AppRootView_Previews: PreviewProvider, SnapshotTestable {
    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        PreviewSnapshots(
            configurations: [
                UITestPreviewType.standard.configuration,
            ],
            configure: { dependency in
                AppRootView(router: AppRootRouter(dependency: dependency))
            }
        )
    }
}
