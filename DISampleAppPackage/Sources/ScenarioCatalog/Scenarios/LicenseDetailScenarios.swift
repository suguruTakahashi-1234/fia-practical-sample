//
//  Created by sugurutakahashi on 2024/02/20
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
@preconcurrency import Playbook
import PresentationLayer

@MainActor
struct LicenseDetailScenarios: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "LicenseDetail") {
            Scenario(type: .small, layout: .fill) {
                LicenseDetailView(dependency: AppRootRouterDependencyMock.sizeS, license: .sizeS)
            }

            Scenario(type: .medium, layout: .fill) {
                LicenseDetailView(dependency: AppRootRouterDependencyMock.sizeM, license: .sizeM)
            }

            Scenario(type: .large, layout: .fill) {
                LicenseDetailView(dependency: AppRootRouterDependencyMock.sizeL, license: .sizeL)
            }
        }
    }
}
