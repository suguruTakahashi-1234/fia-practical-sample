//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import DomainLayer

public struct AppRootView: View {
    private let router: AppRootWireframe
    @StateObject private var presenter: AppRootPresenter

    public init(router: some AppRootWireframe, osLogDriver: some OSLogDriverProtocol, firebaseSetupDriver: some FirebaseSetupDriverProtocol) {
        self.router = router
        _presenter = .init(wrappedValue: .init(osLogDriver: osLogDriver, firebaseSetupDriver: firebaseSetupDriver))
    }
    
    public var body: some View {
        NavigationStack {
            router.createLicenseListView()
                .task {
                    presenter.onAppear()
                }
                .onDisappear {
                    presenter.onDisappear()
                }
        }
    }
}
