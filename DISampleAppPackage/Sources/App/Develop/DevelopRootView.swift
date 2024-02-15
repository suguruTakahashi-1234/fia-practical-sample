//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright © 2024 sugurutakahashi. All rights reserved.
//

import SwiftUI
import DomainLayer
import LicensePresentation
import LoggerFramework

public struct DevelopRootView: View {
    public var body: some View {
        NavigationStack {
            LicenseListView()
        }
    }

    public init() {
        LoggerContainer.append(logger: OSLogger(subsystem: Bundle.main.bundleIdentifier!, category: Constants.Logger.categoryName))

        LoggerContainer.debugLog("completed setup LoggerContainer")
    }
}
