//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct LicenseListView<Router: AppRootWireframe, Dependency: LicenseListPresenterDependency>: View {
    private let router: Router
    @StateObject private var presenter: LicenseListPresenter<Dependency>

    public init(router: Router, dependency: Dependency) {
        self.router = router
        _presenter = .init(wrappedValue: LicenseListPresenter(dependency: dependency))
    }

    public var body: some View {
        List {
            Section("") {
                ForEach(presenter.licenseList) { license in
                    Button {
                        presenter.onTapLicense(license: license)
                    } label: {
                        Text(license.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .navigationTitle("ライセンス")
        .sheet(item: $presenter.selectedLicense, content: { license in
            router.createLicenseDetailView(license: license)
                .navigationStacked()
        })
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

struct LicenseListView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: allSizes,
            configure: { state in
                LicenseListView(router: AppRootRouter.empty, dependency: state)
                    .navigationStacked()
            }
        )
    }
}
