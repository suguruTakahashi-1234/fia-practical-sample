//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable
public protocol BuildEnvDriverProtocol: AnyObject {
    var buildScheme: BuildScheme { get }
    var buildConfiguration: BuildConfiguration { get }
}

public extension BuildEnvDriverProtocol {
    var isStaging: Bool {
        buildScheme == .staging
    }

    var isProduction: Bool {
        buildScheme == .production
    }

    var isDebug: Bool {
        buildConfiguration == .debug
    }

    var isRelease: Bool {
        buildConfiguration == .release
    }

    var isStagingDebug: Bool {
        buildScheme == .staging && buildConfiguration == .debug
    }

    var isStagingRelease: Bool {
        buildScheme == .staging && buildConfiguration == .release
    }

    var isProductionDebug: Bool {
        buildScheme == .production && buildConfiguration == .debug
    }

    var isProductionRelease: Bool {
        buildScheme == .production && buildConfiguration == .release
    }
}
