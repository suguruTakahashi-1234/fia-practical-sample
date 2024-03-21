
import DomainLayer
import Foundation

@MainActor @Observable
final class OnboardingPresenter<Dependency: OnboardingPresenterDependency> {
    var selectedStep: OnboardingStep = .introduction

    private let dependency: Dependency

    init(dependency: Dependency, onboardingStep: OnboardingStep) {
        dependency.logDriver.initLog()

        self.dependency = dependency
        selectedStep = onboardingStep
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    func onAppear() async {
        dependency.logDriver.onAppearLog()
    }

    func onDisappear() {
        dependency.logDriver.onDisappearLog()
    }

    func onTapNextStep() {
        switch selectedStep {
        case .introduction:
            selectedStep = .start
        case .start:
            dependency.localDataStore.isCompletedOnboarding = true
        }
    }
}
