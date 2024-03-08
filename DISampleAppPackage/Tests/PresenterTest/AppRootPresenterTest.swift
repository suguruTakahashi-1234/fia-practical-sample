//
//  Created by sugurutakahashi on 2024/02/29
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
@testable import PresentationLayer
import Testing

@MainActor
struct AppRootPresenterTest {
    var presenter: AppRootPresenter<AppRootRouterDependencyMock>!
    var dependencyInjector: AppRootRouterDependencyMock!

    init() {
        dependencyInjector = .random
        presenter = .init(dependency: dependencyInjector)
    }

    @Test("初期化したとき") func onInit() {
        #expect(dependencyInjector.firebaseSetupDriver.configureCallCount == 1, "Firebaseのセットアップが行われること")
    }

    @Test("画面を表示したとき") func onAppear() async {
        #expect(dependencyInjector.firebaseRemoteConfigDriver.setUpCallCount == 0, "RemoteConfigのセットアップが行われること（前提条件の確認）")
        await presenter.onAppear()
        #expect(dependencyInjector.firebaseRemoteConfigDriver.setUpCallCount == 1, "RemoteConfigのセットアップが行われること")
    }

    @Test("画面を閉じたとき") func onDisappear() {
        presenter.onDisappear()
        #expect(true, "")
    }
}
