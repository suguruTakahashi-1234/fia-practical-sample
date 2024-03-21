//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct LicenseDetailView<Dependency: LicenseDetailPresenterDependency>: View {
    @State private var presenter: LicenseDetailPresenter<Dependency>

    public init(presenter: LicenseDetailPresenter<Dependency>) {
        self.presenter = presenter
    }

    public var body: some View {
        ScrollView {
            Text(presenter.license.text)
                .padding()
        }
        .navigationTitle(presenter.license.name)
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

struct LicenseDetailView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<License> {
        .init(
            configurations: [
                .init(type: .small, state: .sizeS),
                .init(type: .medium, state: .sizeM),
                .init(type: .large, state: .sizeL),
            ],
            configure: { state in
                LicenseDetailView(presenter: LicenseDetailPresenter(dependency: AppRootRouterDependencyMock.random, license: state))
                    .navigationStacked()
            }
        )
    }
}
