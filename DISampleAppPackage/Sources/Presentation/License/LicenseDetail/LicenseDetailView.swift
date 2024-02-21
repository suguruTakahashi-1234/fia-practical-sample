//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import DomainLayer

public struct LicenseDetailView: View {
    @StateObject private var presenter: LicenseDetailPresenter
    
    public init(license: License) {
        _presenter = .init(wrappedValue: .init(license: license))
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
            presenter.onAppear()
        }
        .onDisappear {
            presenter.onDisappear()
        }
    }
}

import PreviewSnapshots

struct LicenseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<License> {
        PreviewSnapshots(
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
