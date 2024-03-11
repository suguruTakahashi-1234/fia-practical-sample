
import DomainLayer
import Foundation

/// @mockable(typealias: CacheDataStoreProtocolAT = CacheDataStoreProtocolMock;)
public protocol TaskListPresenterDependency: CommonPresenterDependency {
    associatedtype CacheDataStoreProtocolAT: CacheDataStoreProtocol

    var cacheDataStore: CacheDataStoreProtocolAT { get }
}
