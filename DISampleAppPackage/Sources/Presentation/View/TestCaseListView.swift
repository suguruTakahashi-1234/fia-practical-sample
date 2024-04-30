//
//  Created by sugurutakahashi on 2024/04/30
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI

struct TestCaseListView<ViewTestCase: ViewCatalogTestCaseProvider>: View {
    var body: some View {
        List {
            Section("Test Case") {
                ForEach(Array(ViewTestCase.allCases)) { testCase in
                    NavigationLink {
                        testCase.testCaseView
                    } label: {
                        Text("\(testCase)")
                    }
                }
            }
            .textCase(nil)
        }
        .navigationTitle("\(ViewTestCase.title)")
    }
}
