//
//  Created by sugurutakahashi on 2024/03/05
//  Copyright sugurutakahashi. All rights reserved.
//

import DependencyInjectionLayer
import DomainLayer
@testable import PresentationLayer
import Testing

/// AppRootDIContainer を用いた場合のサンプル(本物の AppRootDIContainer を使わないと検証できない場合)
/// 本物の AppRootDIContainer を使う場合は Staging や Production での Unit テストで記述することが可能であり、BuildScheme を testing にした場合は正しく GoogleService-Info.plist を読み込むことができないため、そちらを推奨する
@MainActor
struct DeviceInfoInteractorDependencyInjectorActualTest {
    var interactor: DeviceInfoInteractor<AppRootDIContainer>!
    var dependencyInjector: AppRootDIContainer!

    init() {
        dependencyInjector = .init(buildScheme: .testing)
        interactor = .init(dependency: dependencyInjector)
    }

    @Test("デバイス情報の取得を取得するとき") func getDeviceInfoValue() {
        #expect(interactor.getDeviceInfoValue(.buildScheme) == "Testing", "デバイス情報が取得できる（Build Scheme）")
    }
}
