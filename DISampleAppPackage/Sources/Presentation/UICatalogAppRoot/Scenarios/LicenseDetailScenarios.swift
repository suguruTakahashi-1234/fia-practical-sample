//
//  Created by sugurutakahashi on 2024/02/20
//  Copyright sugurutakahashi. All rights reserved.
//

import Playbook
import DomainLayer
import LicensePresentation

struct LicenseDetailScenarios: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "LicenseDetail") {
            Scenario("long string", layout: .fill) {
                LicenseDetailView(license: .random)
            }

            Scenario("short string", layout: .fill) {
                LicenseDetailView(license: .random)
            }
        }
    }
}
