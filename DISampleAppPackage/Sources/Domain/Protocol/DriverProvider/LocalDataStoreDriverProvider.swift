//
//  Created by sugurutakahashi on 2024/03/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable(typealias: LocalDataStoreDriverProtocolAT = LocalDataStoreDriver)
public protocol LocalDataStoreDriverProvider {
    associatedtype LocalDataStoreDriverProtocolAT: LocalDataStoreDriverProtocol

    var localDataStoreDriver: LocalDataStoreDriverProtocolAT { get }
}
