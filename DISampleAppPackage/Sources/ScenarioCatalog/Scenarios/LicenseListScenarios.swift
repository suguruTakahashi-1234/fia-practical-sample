//
//  Created by sugurutakahashi on 2024/02/20
//  Copyright sugurutakahashi. All rights reserved.
//

import Playbook
import DomainLayer
import PresentationLayer

struct LicenseListScenarios: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "LicenseList") {
            Scenario(type: .small, layout: .fill) {
                LicenseListView(router: AppRootRouter.empty, dependency: NonFrameworkDependencyInjector.sizeS)
            }

            Scenario(type: .medium, layout: .fill) {
                LicenseListView(router: AppRootRouter.empty, dependency: NonFrameworkDependencyInjector.sizeM)
            }

            Scenario(type: .large, layout: .fill) {
                LicenseListView(router: AppRootRouter.empty, dependency: NonFrameworkDependencyInjector.sizeL)
            }
            
            Scenario(type: .empty, layout: .fill) {
                LicenseListView(router: AppRootRouter.empty, dependency: NonFrameworkDependencyInjector.empty)
            }
        }
    }
}
