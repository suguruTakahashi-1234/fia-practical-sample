//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import SwiftUI

@MainActor
public struct LicenseListView<Router: LicenseListWireframe, Dependency: LicenseListPresenterDependency>: View {
    private let router: Router
    @StateObject private var presenter: LicenseListPresenter<Dependency>

    public init(router: Router, dependency: Dependency) {
        self.router = router
        _presenter = .init(wrappedValue: LicenseListPresenter(dependency: dependency))
    }

    public var body: some View {
        NavigationStack {
            List {
                ForEach(presenter.licenseList) { license in
                    Button {
                        presenter.onTapLicense(license: license)
                    } label: {
                        Text(license.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .sheet(item: $presenter.selectedLicense, content: { license in
                router.createLicenseDetailView(license: license)
            })
            .navigationTitle("ライセンス")
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

struct LicenseListView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: configurationAllSizes,
            configure: { state in
                LicenseListView(router: AppRootRouter(dependency: AppRootRouterDependencyMock.empty), dependency: state)
            }
        )
    }
}
