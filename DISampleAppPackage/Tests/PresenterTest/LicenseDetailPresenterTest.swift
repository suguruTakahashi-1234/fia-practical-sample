//
//  Created by sugurutakahashi on 2024/02/29
//  Copyright sugurutakahashi. All rights reserved.
//

import Testing
import DomainLayer
@testable import PresentationLayer

@MainActor
struct LicenseDetailPresenterTest {
    var presenter: LicenseDetailPresenter!
    var dependencyInjector: AppRootRouterDependencyMock = .random

    init() {
        presenter = .init(dependency: dependencyInjector)
    }

    @Test("初期化したとき") func onInit() {
        #expect(true, "")
        
    }

    @Test("画面を表示したとき") func onAppear() async {
        await presenter.onAppear()
        #expect(true, "")
    }

    @Test("画面を閉じたとき") func onDisappear() {
        presenter.onDisappear()
        #expect(true, "")
    }
}
