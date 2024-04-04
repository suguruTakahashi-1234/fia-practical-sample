//
//  Created by sugurutakahashi on 2024/03/18
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI

public extension View {
    @MainActor
    func navigationStacked() -> some View {
        NavigationStack {
            self
        }
    }

    // Ref: https://stackoverflow.com/questions/56490250/dynamically-hiding-view-in-swiftui
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    ///
    @ViewBuilder
    func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
