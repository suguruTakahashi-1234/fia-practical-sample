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
    @Environment(\.presentationMode) var presentationMode

    public init(dependency: Dependency, license: License) {
        presenter = LicenseDetailPresenter(dependency: dependency, license: license)
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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    SFSymbols.xmark.image
                }
            }
        }
    }
}

// MARK: - Preview

import PreviewSnapshots

struct LicenseDetailView_Previews: PreviewProvider, SnapshotTestable {
    static var snapshots: PreviewSnapshots<License> {
        .init(
            configurations: [
                .init(type: .small, state: .sizeS),
                .init(type: .medium, state: .sizeM),
                .init(type: .large, state: .sizeL),
            ],
            configure: { license in
                LicenseDetailView(dependency: AppRootDIContainerDependencyMock.random, license: license)
                    .navigationStacked()
            }
        )
    }
}
