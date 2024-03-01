//
//  Created by sugurutakahashi on 2024/02/20
//  Copyright sugurutakahashi. All rights reserved.
//

import Playbook
import PresentationLayer
import SwiftUI

package extension Scenario {
    init(
        type: UITestPreviewType,
        layout: ScenarioLayout,
        file: StaticString = #filePath,
        line: UInt = #line,
        content: @escaping () -> some View
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
