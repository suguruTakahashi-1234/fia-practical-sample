//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import DomainLayer

public struct AppRootView: View {
    private let router: RootWireframe
    @StateObject private var presenter: AppRootPresenter = .init()

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

    public init(router: some RootWireframe) {
        self.router = router
    }
}
