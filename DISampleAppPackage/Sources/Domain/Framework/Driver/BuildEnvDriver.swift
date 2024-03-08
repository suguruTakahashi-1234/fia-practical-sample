//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public class BuildEnvDriver: BuildEnvDriverProtocol {
    public let buildScheme: BuildScheme
    public let buildConfiguration: BuildConfiguration

    public init(buildScheme: BuildScheme) {
        LogDriver.initLog()

        self.buildScheme = buildScheme

        #if DEBUG
            buildConfiguration = .debug
        #else
            buildConfiguration = .release
        #endif
    }

    deinit {
        LogDriver.deinitLog()
    }
}
