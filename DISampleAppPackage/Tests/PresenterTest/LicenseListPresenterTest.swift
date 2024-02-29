//
//  Created by sugurutakahashi on 2024/02/28
//  Copyright sugurutakahashi. All rights reserved.
//
//

import Testing
@testable import PresentationLayer

@MainActor
struct LicenseListPresenterTest {
    var presenter: LicenseListPresenter!
    var dependencyInjector: LicenseListPresenterDependencyMock!
    
    init() {
        dependencyInjector = .init()
        presenter = .init(dependency: dependencyInjector)
    }
    
    @Test func onInit() {
        #expect(presenter.licenseList.isEmpty)
    }
    
    @Test func onAppear() async {
        await presenter.onAppear()
    }
    
    @Test func onDisappear() {
        presenter.onDisappear()
    }
}
