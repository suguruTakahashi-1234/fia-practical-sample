//
//  Created by sugurutakahashi on 2024/02/20
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Playbook
import PresentationLayer

struct LicenseDetailScenarios: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "LicenseDetail") {
            Scenario(type: .small, layout: .fill) {
                LicenseDetailView(license: .sizeS)
            }

            Scenario(type: .medium, layout: .fill) {
                LicenseDetailView(license: .sizeM)
            }

            Scenario(type: .large, layout: .fill) {
                LicenseDetailView(license: .sizeL)
            }
        }
    }
}
