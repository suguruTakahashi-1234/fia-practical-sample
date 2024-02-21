//
//  Created by sugurutakahashi on 2024/02/20
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import Playbook
import PresentationLayer

package extension Scenario {
    init<Content: View>(
        type: UITestScenarioType,
        layout: ScenarioLayout,
        file: StaticString = #file,
        line: UInt = #line,
        content: @escaping () -> Content
    ) {
        self.init(
            ScenarioName(rawValue: type.name),
            layout: layout,
            file: file,
            line: line,
            content: content
        )
    }
}
