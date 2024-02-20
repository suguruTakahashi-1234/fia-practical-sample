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
            Scenario("long string", layout: .fill) {
                LicenseListView(router: UICatalogRouter.shared, dependency: StubDependencyInjector.randomScenario)
            }

            Scenario("short string", layout: .fill) {
                LicenseListView(router: UICatalogRouter.shared, dependency: StubDependencyInjector.randomScenario)
            }

            Scenario("empty", layout: .fill) {
                LicenseListView(router: UICatalogRouter.shared, dependency: StubDependencyInjector.emptyScenario)
            }
        }
    }
}
