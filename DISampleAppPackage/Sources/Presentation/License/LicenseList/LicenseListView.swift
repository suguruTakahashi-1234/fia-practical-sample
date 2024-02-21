//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import DomainLayer

public struct LicenseListView: View {
    private let router: LicenseListWireframe
    @StateObject private var presenter: LicenseListPresenter

    public init(router: some LicenseListWireframe, dependency: some LicenseListPresenterDependency) {
        self.router = router
        _presenter = .init(wrappedValue: .init(dependency: dependency))
    }

    public var body: some View {
        List {
            ForEach(presenter.licenseList) { license in
                Button {
                    presenter.licenseTapped(license: license)
                } label: {
                    Text(license.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .sheet(item: $presenter.selectedLicense) { license in
            router.createLicenseDetailView(license: license)
        }
        .navigationTitle("ライセンス")
        .task {
            presenter.onAppear()
        }
        .onDisappear {
            presenter.onDisappear()
        }
    }
}

import PreviewSnapshots

struct LicenseListView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependency> {
        .init(
            configurations: allSizeConfigurations,
            configure: { state in
                LicenseListView(router: AppRootRouter.empty, dependency: state)
            }
        )
    }
}
