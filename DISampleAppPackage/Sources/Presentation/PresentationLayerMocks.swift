///
/// @Generated by Mockolo
///



import DomainLayer
import Foundation


public final class AppRootWireframeMock: AppRootWireframe {
    public init() { }


    public private(set) var createLicenseListViewCallCount = 0
    public var createLicenseListViewHandler: (() -> (LicenseListView))?
    public func createLicenseListView() -> LicenseListView {
        createLicenseListViewCallCount += 1
        if let createLicenseListViewHandler = createLicenseListViewHandler {
            return createLicenseListViewHandler()
        }
        fatalError("createLicenseListViewHandler returns can't have a default value thus its handler must be set")
    }
}

public final class LicenseListWireframeMock: LicenseListWireframe {
    public init() { }


    public private(set) var createLicenseDetailViewCallCount = 0
    public var createLicenseDetailViewHandler: ((License) -> (LicenseDetailView))?
    public func createLicenseDetailView(license: License) -> LicenseDetailView {
        createLicenseDetailViewCallCount += 1
        if let createLicenseDetailViewHandler = createLicenseDetailViewHandler {
            return createLicenseDetailViewHandler(license)
        }
        fatalError("createLicenseDetailViewHandler returns can't have a default value thus its handler must be set")
    }
}

