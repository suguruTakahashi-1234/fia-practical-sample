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
    var isProductionRelease: Bool {
        buildScheme == .production && buildConfiguration == .release
    }
}
