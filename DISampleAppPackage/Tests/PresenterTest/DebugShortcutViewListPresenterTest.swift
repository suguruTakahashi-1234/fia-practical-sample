//
//  Created by sugurutakahashi on 2024/04/06
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
@testable import PresentationLayer
import Testing

@MainActor
struct DebugShortcutViewListPresenterTest {
    var presenter: DebugShortcutViewListPresenter<AppRootDIContainerDependencyMock>!
    var dependencyInjector: AppRootDIContainerDependencyMock!

    init() {
        dependencyInjector = .random
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
