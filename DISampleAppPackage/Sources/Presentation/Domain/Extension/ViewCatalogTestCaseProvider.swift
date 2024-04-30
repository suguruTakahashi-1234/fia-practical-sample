//
//  Created by sugurutakahashi on 2024/04/30
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI

public protocol ViewCatalogTestCaseProvider: Identifiable, CaseIterable, Hashable {
    associatedtype T: View

    static var title: String { get }

    @MainActor @ViewBuilder
    var testCaseView: T { get }
}

public extension ViewCatalogTestCaseProvider {
    static var title: String {
        "\(Self.self)".sliceToViewName
    }

    var id: String {
        "\(self)"
    }
}
