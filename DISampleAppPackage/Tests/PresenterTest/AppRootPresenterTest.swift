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
    var firebaseSetupDriver: FirebaseSetupDriverProtocolMock!

    init() {
        firebaseSetupDriver = .init()
        dependencyInjector = .create(
            firebaseSetupDriver: firebaseSetupDriver
        )
        presenter = .init(dependency: dependencyInjector)
    }

    @Test("初期化したとき") func onInit() {
        #expect(firebaseSetupDriver.configureCallCount == 1, "Firebaseのセットアップが行われること")
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
