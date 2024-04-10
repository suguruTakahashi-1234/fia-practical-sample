//
//  Created by sugurutakahashi on 2024/04/06
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
@testable import PresentationLayer
import Testing

/// AppRootRouterDependencyMock を用いた場合のサンプル(本物の AppRootDependencyInjector を使わなくてもよい場合)
/// Development での Unit テストで記述することもできるが、そうすると Development を scheme に指定したときに、SwiftUI のプレビューの生成に失敗するので、本物の AppRootDependencyInjector を使わなくてもよい場合は SPM 側のテストで記述することを推奨する
@MainActor
struct DeviceInfoInteractorDependencyInjectorMockTest {
    var interactor: DeviceInfoInteractor<AppRootRouterDependencyMock>!
    var dependencyInjector: AppRootRouterDependencyMock!

    init() {
        dependencyInjector = .random
        interactor = .init(dependency: dependencyInjector)
    }

    @Test("デバイス情報の取得を取得するとき") func getDeviceInfoValue() {
        #expect(interactor.getDeviceInfoValue(.buildScheme) == "Development", "デバイス情報が取得できる（Build Scheme）")
    }
}
