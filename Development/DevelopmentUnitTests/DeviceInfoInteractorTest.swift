//
//  Created by sugurutakahashi on 2024/04/06
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
@testable import PresentationLayer
import XCTest

final class DeviceInfoInteractorTest: XCTestCase {
    var interactor: DeviceInfoInteractor<AppRootRouterDependencyMock>!
    var dependencyInjector: AppRootRouterDependencyMock!

    @MainActor
    override func setUpWithError() throws {
        dependencyInjector = .random
        interactor = .init(dependency: dependencyInjector)
    }

    @MainActor
    func testGetDeviceInfoValue() {
        XCTAssertEqual(interactor.getDeviceInfoValue(.buildScheme), "Development", "デバイス情報が取得できる（Build Scheme）")
    }
}
