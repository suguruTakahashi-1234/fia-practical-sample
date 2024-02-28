//
//  Created by sugurutakahashi on 2024/02/29
//  Copyright sugurutakahashi. All rights reserved.
//

import Testing
@testable import PresentationLayer

@Test func 挨拶の文字列が正しいこと() { // ✅ グローバル関数として定義可能
    let greeting = "Hello Swift"
    #expect(greeting == "Hello Swift")
}

final class SomeTests {
    @Test func someValueが999であること() async throws { // ✅ asyncとthrowsのキーワードを含めることが可能
        let someValue = try await makeSomeValue()
        #expect(someValue == 999)
    }
    
    
    @Test static func someStaticTests() { /* ... */ } // ✅ 静的メソッドとして定義可能
}

func makeSomeValue() async throws -> Int {
    99
}

//class LicenseListPresenterTest: QuickSpec {
//    override class func spec() {
//        describe("LicenseListPresenterTest") {
//            var presenter: LicenseListPresenter
//            var dependencyInjector: LicenseListPresenterDependencyMock!
//
//            beforeEach {
//                dependencyInjector = .init()
//                await presenter = Task.detached {
//                    await .init(dependency: dependencyInjector)
//                }
//            }
//
//            describe("") {
//                context("") {
//                    beforeEach {
//                    }
//                    it("") {
//                    }
//                }
//            }
//        }
//    }
//}
//
//
//class LicenseListPresenterTests: XCTestCase {
//    var presenter: LicenseListPresenter!
//    var dependencyInjector: LicenseListPresenterDependencyMock!
//
//    override func setUp() async throws {
//        try await super.setUp()
//
//        dependencyInjector = .init()
//        presenter = await .init(dependency: dependencyInjector)
//    }
//
//    override func tearDown() {
//        dependencyInjector = nil
//        presenter = nil
//
//        super.tearDown()
//    }
//
//    func testInitialization() {
//        let licenses = [License(name: "Test License", details: "Some details")]
//        let driver = MockLibraryLicenseDriver(licenses: licenses)
//        let dependency = MockLicenseListPresenterDependency(libraryLicenseDriver: driver)
//        let presenter = LicenseListPresenter(dependency: dependency)
//
//        XCTAssertTrue(MockLoggerContainer.initLogCalled, "initLog was not called")
//        XCTAssertEqual(presenter.licenseList, licenses, "License list was not initialized correctly")
//    }
//
//    func testOnAppear() {
//        let presenter = makePresenter()
//        presenter.onAppear()
//
//        XCTAssertTrue(MockLoggerContainer.logOnAppearCalled, "logOnAppear was not called")
//    }
//
//    func testOnDisappear() {
//        let presenter = makePresenter()
//        presenter.onDisappear()
//
//        XCTAssertTrue(MockLoggerContainer.logOnDisappearCalled, "logOnDisappear was not called")
//    }
//
//    func testOnTapLicense() {
//        let licenses = [License(name: "Test License", details: "Some details")]
//        let presenter = makePresenter(licenses: licenses)
//        let expectedLicense = licenses.first!
//
//        presenter.onTapLicense(license: expectedLicense)
//
//        XCTAssertEqual(presenter.selectedLicense, expectedLicense, "Selected license was not updated correctly")
//    }
//
//    private func makePresenter(licenses: [License] = []) -> LicenseListPresenter {
//        MockLoggerContainer.reset()
//        let driver = MockLibraryLicenseDriver(licenses: licenses)
//        let dependency = MockLicenseListPresenterDependency(libraryLicenseDriver: driver)
//        return LicenseListPresenter(dependency: dependency)
//    }
//}
