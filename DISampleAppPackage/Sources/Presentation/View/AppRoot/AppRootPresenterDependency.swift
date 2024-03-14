//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

/// @mockable(typealias: LocalDataStoreProtocolAT = LocalDataStore)
public protocol AppRootPresenterDependency: CommonPresenterDependency {
    associatedtype LocalDataStoreProtocolAT: LocalDataStoreProtocol

    var localDataStore: LocalDataStoreProtocolAT { get }
}
