//
//  Created by sugurutakahashi on 2024/03/21
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
@testable import PresentationLayer
import Testing

@MainActor
struct HomeTabPresenterTest {
    var presenter: HomeTabPresenter<AppRootRouterDependencyMock>!
    var dependencyInjector: AppRootRouterDependencyMock!

    init() {
        dependencyInjector = .random
        presenter = .init(dependency: dependencyInjector, homeTab: .setting)
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
