//
//  Created by sugurutakahashi on 2024/04/04
//  Copyright sugurutakahashi. All rights reserved.
//

import DependencyInjectionLayer
import DomainLayer
@testable import PresentationLayer
import XCTest

final class DeviceInfoInteractorTest: XCTestCase {
    var interactor: DeviceInfoInteractor<AppRootDIContainer>!
    var dependencyInjector: AppRootDIContainer!

    @MainActor
    override func setUpWithError() throws {
        dependencyInjector = .init(buildScheme: .staging)
        interactor = .init(dependency: dependencyInjector)
    }

    @MainActor
    func testGetDeviceInfoValue() {
        XCTAssertEqual(interactor.getDeviceInfoValue(.buildScheme), "Staging", "デバイス情報が取得できる（Build Scheme）")
    }
}
