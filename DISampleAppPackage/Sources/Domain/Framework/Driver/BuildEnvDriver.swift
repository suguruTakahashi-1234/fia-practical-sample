//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public final class BuildEnvDriver: BuildEnvDriverProtocol {
    public let buildScheme: BuildScheme

    /// .debug なのか .release なのかを気にしなくて済むように BuildConfiguration はイニシャライザの引数で指定せず、実際のビルド環境を適応させていて、もし、検証が必要なときは Mock を使う方針（要検討）
    public let buildConfiguration: BuildConfiguration

    public init(buildScheme: BuildScheme) {
        OSLogDriver.initLog()

        self.buildScheme = buildScheme

        #if DEBUG
            buildConfiguration = .debug
        #else
            buildConfiguration = .release
        #endif
    }

    deinit {
        OSLogDriver.deinitLog()
    }
}
