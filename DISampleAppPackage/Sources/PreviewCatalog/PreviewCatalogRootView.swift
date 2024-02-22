//
//  Created by sugurutakahashi on 2024/02/22
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import PreviewGallery

public struct PreviewCatalogRootView: View {

    public init() {}
    
    public var body: some View {
        NavigationStack {
            PreviewGallery()
        }
    }
}
