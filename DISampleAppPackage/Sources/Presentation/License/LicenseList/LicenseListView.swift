//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import SwiftUI

@MainActor
public struct LicenseListView: View {
    private let router: any LicenseListWireframe
    @StateObject private var presenter: LicenseListPresenter

    public init(router: any LicenseListWireframe, dependency: some LicenseListPresenterDependency) {
        self.router = router
        _presenter = .init(wrappedValue: LicenseListPresenter(dependency: dependency))
    }

    public var body: some View {
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
            configurations: configurationAllSizesWithEmpty,
            configure: { state in
                LicenseListView(router: AppRootRouter<AppRootRouterDependencyMock>(dependency: AppRootRouterDependencyMock.empty), dependency: state)
            }
        )
    }
}
