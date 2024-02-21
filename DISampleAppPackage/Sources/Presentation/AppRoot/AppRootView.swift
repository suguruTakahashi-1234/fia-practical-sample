//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import DomainLayer

public struct AppRootView: View {
    private let router: AppRootWireframe
    @StateObject private var presenter: AppRootPresenter

    public init(router: some AppRootWireframe, dependency: some AppRootPresenterDependency) {
        self.router = router
        _presenter = .init(wrappedValue: .init(dependency: dependency))
    }
    
    public var body: some View {
        NavigationStack {
            router.createLicenseListView()
                .task {
                    presenter.onAppear()
                }
                .onDisappear {
                    presenter.onDisappear()
                }
        }
    }
}

import PreviewSnapshots

struct AppRootView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews.fixedSize(horizontal: false, vertical: false)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependency> {
        PreviewSnapshots(
            configurations: emptyConfiguration,
            configure: { state in
                AppRootView(router: AppRootRouter.empty, dependency: state)
            }
        )
    }
}
