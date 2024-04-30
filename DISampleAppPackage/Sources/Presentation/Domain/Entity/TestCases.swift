//
//  Created by sugurutakahashi on 2024/04/30
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI

public enum LicenseListViewTestCase: ViewCatalogTestCaseProvider {
    case normal
    case empty

    @MainActor @ViewBuilder
    public var testCaseView: some View {
        switch self {
        case .normal:
            LicenseListView(dependency: AppRootDIContainerDependencyMock.placeholder)
        case .empty:
            LicenseListView(dependency: AppRootDIContainerDependencyMock.empty)
        }
    }
}
