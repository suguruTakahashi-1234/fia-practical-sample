
import DomainLayer
import Foundation

/// @mockable(typealias: LocalDataStoreProtocolAT = LocalDataStore;)
public protocol OnboardingPresenterDependency: CommonPresenterDependency, LocalDataStoreProvider {}
