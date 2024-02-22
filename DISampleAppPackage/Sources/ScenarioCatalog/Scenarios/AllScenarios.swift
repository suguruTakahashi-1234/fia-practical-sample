//
//  Created by sugurutakahashi on 2024/02/20
//  Copyright sugurutakahashi. All rights reserved.
//

import Playbook

public struct AllScenarios: ScenarioProvider {
    public static func addScenarios(into playbook: Playbook) {
        playbook
            .add(LicenseListScenarios.self)
            .add(LicenseDetailScenarios.self)
    }
}
