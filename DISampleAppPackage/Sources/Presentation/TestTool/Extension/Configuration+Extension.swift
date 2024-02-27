//
//  Created by sugurutakahashi on 2024/02/21
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import PreviewSnapshots

public extension PreviewSnapshots.Configuration {
    init(type: UITestPreviewType, state: State) {
        self.init(name: type.name, state: state)
    }
}
