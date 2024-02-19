//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright © 2024 sugurutakahashi. All rights reserved.
//

import SwiftUI
import PlaybookUI

public struct UICatalogRootView: View {
    public var body: some View {
        PlaybookScreen()
    }

    public init() {
        Playbook.default.add(AllScenarios.self)
    }
}

import SwiftUI
import PlaybookUI

struct PlaybookScreen: View {
    enum Tab {
        case catalog
        case gallery
    }

    @State var tab: Tab = .gallery
    
    var body: some View {        
        TabView(selection: $tab) {
            PlaybookGallery()
                .tag(Tab.gallery)
                .tabItem {
                    Image(systemName: "rectangle.grid.3x2")
                        .accessibilityHidden(true)
                    Text("Gallery")
                }

            PlaybookCatalog()
                .tag(Tab.catalog)
                .tabItem {
                    Image(systemName: "doc.text.magnifyingglass")
                        .accessibilityHidden(true)
                    Text("Catalog")
                }
        }
    }
}


import Playbook

struct AllScenarios: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook
            .add(LicenseListScenarios.self)
            .add(LicenseDetailScenarios.self)
    }
}

import LicensePresentation
import DomainLayer

struct LicenseListScenarios: ScenarioProvider {
    struct LicenseListPresenterDependencyStub: LicenseListPresenterDependency {
        var libraryLicenseDriver: any DomainLayer.LibraryLicenseDriverProtocol = LibraryLicenseDriverProtocolStub(licenseList: [.random])
    }
    
    struct LibraryLicenseDriverProtocolStub: LibraryLicenseDriverProtocol {
        var licenseList: [DomainLayer.License]
    }
    
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "LicenseList") {
            Scenario("title long", layout: .fill) {
                LicenseListView(router: UICatalogRouter.shared, dependency: LicenseListPresenterDependencyStub())
            }

            Scenario("title short", layout: .fill) {
                LicenseListView(router: UICatalogRouter.shared, dependency: UICatalogDependencyInjector())
            }
        }
    }
}

struct LicenseDetailScenarios: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "LicenseDetail") {
            Scenario("title long", layout: .fill) {
                LicenseDetailView(license: .random)
            }

            Scenario("title short", layout: .fill) {
                LicenseDetailView(license: .random)
            }
        }
    }
}
