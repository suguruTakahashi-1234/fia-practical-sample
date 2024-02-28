//
//  Created by sugurutakahashi on 2024/02/20
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Playbook
import PresentationLayer

struct LicenseListScenarios: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "LicenseList") {
            Scenario(type: .small, layout: .fill) {
                LicenseListView(router: AppRootRouter.empty, dependency: AppRootRouterDependencyMock.sizeS)
            }

            Scenario(type: .medium, layout: .fill) {
                LicenseListView(router: AppRootRouter.empty, dependency: AppRootRouterDependencyMock.sizeM)
            }

            Scenario(type: .large, layout: .fill) {
                LicenseListView(router: AppRootRouter.empty, dependency: AppRootRouterDependencyMock.sizeL)
            }

            Scenario(type: .empty, layout: .fill) {
                LicenseListView(router: AppRootRouter.empty, dependency: AppRootRouterDependencyMock.empty)
            }
        }
    }
}
