//
//  Created by sugurutakahashi on 2024/03/05
//  Copyright sugurutakahashi. All rights reserved.
//

import DependencyInjectionLayer
import DomainLayer
@testable import PresentationLayer
import Testing

@MainActor
struct DeviceInfoInteractorTest {
    var interactor: DeviceInfoInteractor<AppRootDependencyInjector>!
    var dependencyInjector: AppRootDependencyInjector!

    init() {
        dependencyInjector = .init(buildScheme: .testing)
        interactor = .init(dependency: dependencyInjector)
    }

    @Test("デバイス情報の取得を取得するとき") func getDeviceInfoValue() {
        #expect(interactor.getDeviceInfoValue(.buildScheme) == "Testing", "デバイス情報が取得できる（Build Scheme）")
    }
}
