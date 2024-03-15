//
//  Created by sugurutakahashi on 2024/03/11
//  Copyright sugurutakahashi. All rights reserved.
//

import Testing
import XCTest

/// Ref: https://swiftpackageindex.com/apple/swift-testing/main/documentation/testing/temporarygettingstarted
/// As of Swift 5.10, the testing library is not integrated into Swift Package Manager, but a temporary mechanism is provided for developers who want to start using it with their Swift packages and the Swift 5.10 toolchain.
/// To use the testing library with Swift 5.10, add a new Swift source file to your package’s test target named “Scaffolding.swift”. Add the following code to it:
final class AllTests: XCTestCase {
    func testAll() async {
        await XCTestScaffold.runAllTests(hostedBy: self)
    }
}
