//
//  Created by sugurutakahashi on 2024/02/20
//  Copyright sugurutakahashi. All rights reserved.
//

import Playbook
import DomainLayer
import LicensePresentation

struct LicenseListScenarios: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "LicenseList") {
            Scenario(type: .small, layout: .fill) {
                LicenseListView(router: UICatalogRouter.shared, dependency: StubDependencyInjector.sizeS)
            }

            Scenario(type: .medium, layout: .fill) {
                LicenseListView(router: UICatalogRouter.shared, dependency: StubDependencyInjector.sizeM)
            }

            Scenario(type: .large, layout: .fill) {
                LicenseListView(router: UICatalogRouter.shared, dependency: StubDependencyInjector.sizeL)
            }
            
            Scenario(type: .empty, layout: .fill) {
                LicenseListView(router: UICatalogRouter.shared, dependency: StubDependencyInjector.empty)
            }
        }
    }
}
