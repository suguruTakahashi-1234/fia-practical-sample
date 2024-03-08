
import DomainLayer
import Foundation

/// @mockable(typealias: CacheDataStoreProtocolAT = CacheDataStoreProtocolMock;)
public protocol TaskListPresenterDependency {
    associatedtype CacheDataStoreProtocolAT: CacheDataStoreProtocol

    var cacheDataStore: CacheDataStoreProtocolAT { get }
}
