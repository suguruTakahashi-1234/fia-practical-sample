//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import DomainLayer

public struct LicenseListView: View {
    @StateObject private var presenter: LicenseListPresenter = .init()

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
            LicenseDetailView(license: license)
        }
        .navigationTitle("ライセンス")
        .task {
            presenter.onAppear()
        }
        .onDisappear {
            presenter.onDisappear()
        }
    }

    public init() {}
}
