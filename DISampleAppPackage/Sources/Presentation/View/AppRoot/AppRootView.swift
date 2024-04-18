//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct AppRootView<Dependency: AppRootDIContainerDependency>: View {
    private let dependency: Dependency
    @State private var presenter: AppRootPresenter<Dependency>

    public init(dependency: Dependency) {
        self.dependency = dependency
        presenter = AppRootPresenter(dependency: dependency)
    }

    public var body: some View {
        Group {
            if presenter.isCompletedOnboarding {
                HomeTabView(dependency: dependency)
            } else {
                OnboardingView(dependency: dependency)
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
    static var snapshots: PreviewSnapshots<AppRootDIContainerDependencyMock> {
        PreviewSnapshots(
            configurations: [
                UITestPreviewType.standard.configuration,
            ],
            configure: { dependency in
                AppRootView(dependency: dependency)
            }
        )
    }
}
