//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import SwiftUI

@MainActor
public struct LicenseDetailView<Dependency: LicenseDetailPresenterDependency>: View {
    @StateObject private var presenter: LicenseDetailPresenter<Dependency>

    public init(dependency: Dependency, license: License) {
        _presenter = .init(wrappedValue: LicenseDetailPresenter(dependency: dependency, license: license))
    }

    public var body: some View {
        NavigationStack {
            ScrollView {
                Text(presenter.license.text)
                    .padding()
            }
            .navigationTitle(presenter.license.name)
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
                LicenseDetailView(dependency: AppRootRouterDependencyMock.random, license: state)
            }
        )
    }
}
