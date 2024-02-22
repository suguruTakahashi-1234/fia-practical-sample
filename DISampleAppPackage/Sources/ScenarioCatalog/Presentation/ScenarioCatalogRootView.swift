//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright © 2024 sugurutakahashi. All rights reserved.
//

import SwiftUI
import PlaybookUI

public struct ScenarioCatalogRootView: View {
    @State private var selectedTab: ScenarioCatalogRootTab = .gallery
    
    public init() {
        Playbook.default.add(AllScenarios.self)
    }

    public var body: some View {
        TabView(selection: $selectedTab) {
            PlaybookGallery()
                .tag(ScenarioCatalogRootTab.gallery)
                .tabItem {
                    Image(systemName: "rectangle.grid.3x2")
                        .accessibilityHidden(true)
                    Text("Gallery")
                }

            PlaybookCatalog()
                .tag(ScenarioCatalogRootTab.catalog)
                .tabItem {
                    Image(systemName: "doc.text.magnifyingglass")
                        .accessibilityHidden(true)
                    Text("Catalog")
                }
        }
    }
}
