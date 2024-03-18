
import DomainLayer
import SwiftUI

@MainActor
public struct OnboardingView<Router: AppRootWireframe, Dependency: OnboardingPresenterDependency>: View {
    private let router: Router
    @StateObject private var presenter: OnboardingPresenter<Dependency>

    public init(router: Router, dependency: Dependency) {
        self.router = router
        _presenter = .init(wrappedValue: OnboardingPresenter(dependency: dependency))
    }

    public var body: some View {
        VStack {
            Text("OnboardingView")
        }
        .navigationTitle("OnboardingView")
        .task {
            await presenter.onAppear()
        }
        .onDisappear {
            presenter.onDisappear()
        }
    }
}

// MARK: - Preview

import PreviewSnapshots

struct OnboardingView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: configurationAllSizesWithEmpty,
            configure: { state in
                OnboardingView(router: AppRootRouter.empty, dependency: state)
                    .navigationStacked()
            }
        )
    }
}
