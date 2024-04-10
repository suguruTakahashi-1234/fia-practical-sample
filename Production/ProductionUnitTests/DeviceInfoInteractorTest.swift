//
//  Created by sugurutakahashi on 2024/04/04
//  Copyright sugurutakahashi. All rights reserved.
//

import DependencyInjectionLayer
import DomainLayer
@testable import PresentationLayer
import XCTest

final class DeviceInfoInteractorTest: XCTestCase {
    var interactor: DeviceInfoInteractor<AppRootRouterDependencyInjector>!
    var dependencyInjector: AppRootRouterDependencyInjector!

    @MainActor
    override func setUpWithError() throws {
        dependencyInjector = .init(buildScheme: .production)
        interactor = .init(dependency: dependencyInjector)
    }

    @MainActor
    func testGetDeviceInfoValue() {
        XCTAssertEqual(interactor.getDeviceInfoValue(.buildScheme), "Production", "デバイス情報が取得できる（Build Scheme）")
    }
}
