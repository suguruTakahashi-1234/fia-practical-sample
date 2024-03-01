
import DomainLayer
import Foundation

public protocol AppRootTabWireframe {}

// TODO: Delete after AppRootTabWireframe to AppRootRouter
extension AppRootRouter: AppRootTabWireframe {}

// TODO: Add transition source Wireframe
//    associatedtype AppRootTabWireframeAT: AppRootTabWireframe
//    associatedtype AppRootTabPresenterDependencyAT: AppRootTabPresenterDependency
//
//    func createAppRootTabView() -> AppRootTabView<AppRootTabWireframeAT, AppRootTabPresenterDependencyAT>

// TODO: Add Router
//    @MainActor
//    public func createAppRootTabView() -> AppRootTabView<Self, Dependency> {
//        AppRootTabView(router: self, dependency: dependency)
//    }
