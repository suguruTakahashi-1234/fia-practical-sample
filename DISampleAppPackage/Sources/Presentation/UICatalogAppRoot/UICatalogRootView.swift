//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright © 2024 sugurutakahashi. All rights reserved.
//

import SwiftUI
import PlaybookUI

private enum UICatalogRootTab {
    case gallery
    case catalog
}

public struct UICatalogRootView: View {
    @State private var selectedTab: UICatalogRootTab = .gallery
    
    public init() {
        Playbook.default.add(AllScenarios.self)
    }

    public var body: some View {
        TabView(selection: $selectedTab) {
            PlaybookGallery()
                .tag(UICatalogRootTab.gallery)
                .tabItem {
                    Image(systemName: "rectangle.grid.3x2")
                        .accessibilityHidden(true)
                    Text("Gallery")
                }

            PlaybookCatalog()
                .tag(UICatalogRootTab.catalog)
                .tabItem {
                    Image(systemName: "doc.text.magnifyingglass")
                        .accessibilityHidden(true)
                    Text("Catalog")
                }
        }
    }
}
