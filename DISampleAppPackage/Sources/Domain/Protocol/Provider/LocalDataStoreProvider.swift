//
//  Created by sugurutakahashi on 2024/03/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable(typealias: LocalDataStoreProtocolAT = LocalDataStore)
public protocol LocalDataStoreProvider {
    associatedtype LocalDataStoreProtocolAT: LocalDataStoreProtocol

    var localDataStore: LocalDataStoreProtocolAT { get }
}
