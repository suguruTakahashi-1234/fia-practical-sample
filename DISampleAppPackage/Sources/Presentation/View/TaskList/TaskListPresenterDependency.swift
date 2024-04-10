
import DomainLayer
import Foundation

/// @mockable(typealias: CacheDataStoreDriverProtocolAT = CacheDataStoreDriverProtocolMock;)
public protocol TaskListPresenterDependency: CommonPresenterDependency {
    associatedtype CacheDataStoreDriverProtocolAT: CacheDataStoreDriverProtocol

    var cacheDataStoreDriver: CacheDataStoreDriverProtocolAT { get }
}
