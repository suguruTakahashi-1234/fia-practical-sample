//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import DomainLayer

struct LicenseDetailView: View {
    @StateObject private var presenter: LicenseDetailPresenter
    
    init(license: License) {
        _presenter = .init(wrappedValue: .init(license: license))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(presenter.license.text)
                    .padding()
            }
            .navigationTitle(presenter.license.name)
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            presenter.onAppear()
        }
        .onDisappear {
            presenter.onDisappear()
        }
    }
}
