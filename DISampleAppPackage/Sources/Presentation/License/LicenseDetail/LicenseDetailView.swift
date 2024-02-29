//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import SwiftUI

public struct LicenseDetailView: View {
    @StateObject private var presenter: LicenseDetailPresenter

    public init(license: License) {
        _presenter = .init(wrappedValue: LicenseDetailPresenter(license: license))
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
                LicenseDetailView(license: state)
            }
        )
    }
}
