//
//  Created by sugurutakahashi on 2024/02/28
//  Copyright sugurutakahashi. All rights reserved.
//
//

import DomainLayer
@testable import PresentationLayer
import Testing

@MainActor
struct LicenseListPresenterTest {
    var presenter: LicenseListPresenter!
    var dependencyInjector: AppRootRouterDependencyMock!
    var license: License!

    init() {
        license = .random
        dependencyInjector = .random
        presenter = .init(dependency: dependencyInjector)
    }

    @Test("初期化したとき") func onInit() {
        #expect(presenter.licenseList.isEmpty, "ライセンス一覧は未取得であること")
        #expect(presenter.selectedLicense.isNil, "ライセンスは選択されていないこと")
    }

    @Test("画面を表示したとき") func onAppear() async {
        await presenter.onAppear()
        #expect(presenter.licenseList.isNotEmpty, "ライセンス一覧は取得済みであること")
    }

    @Test("画面を閉じたとき") func onDisappear() {
        presenter.onDisappear()
        #expect(true, "")
    }

    @Test("ライセンスをタップしたとき") func onTapLicense() {
        presenter.onTapLicense(license: license)
        #expect(presenter.selectedLicense!.id == license.id, "ライセンスが選択されていること")
    }
}
