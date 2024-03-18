//
//  Created by sugurutakahashi on 2024/03/18
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI

extension View {
    @MainActor
    func navigationStacked() -> some View {
        NavigationStack {
            self
        }
    }
}
