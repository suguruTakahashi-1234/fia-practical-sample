//
//  Created by sugurutakahashi on 2024/04/03
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable(typealias: BuildEnvDriverProtocolAT = BuildEnvDriverProtocolMock;)
public protocol BuildEnvDriverProvider {
    associatedtype BuildEnvDriverProtocolAT: BuildEnvDriverProtocol

    var buildEnvDriver: BuildEnvDriverProtocolAT { get }
}
