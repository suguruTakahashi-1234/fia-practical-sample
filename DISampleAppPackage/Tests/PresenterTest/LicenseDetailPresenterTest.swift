//
//  Created by sugurutakahashi on 2024/02/29
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
@testable import PresentationLayer
import Testing

@MainActor
struct LicenseDetailPresenterTest {
    var presenter: LicenseDetailPresenter<AppRootRouterDependencyMock>!
    var dependencyInjector: AppRootRouterDependencyMock!
    var license: License!

    init() {
        license = .random
        dependencyInjector = .random
        presenter = .init(dependency: dependencyInjector, license: license)
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
