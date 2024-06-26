
import DomainLayer
@testable import PresentationLayer
import Testing

@MainActor
struct DebugMenuPresenterTest {
    var presenter: DebugMenuPresenter<AppRootDIContainerDependencyMock>!
    var dependencyInjector: AppRootDIContainerDependencyMock!

    init() {
        dependencyInjector = .random
        presenter = .init(dependency: dependencyInjector)
    }

    @Test("初期化したとき") func onInit() {
        #expect(true, "")
    }

    @Test("画面を表示したとき") func onAppear() async {
        await presenter.onAppear()
        #expect(true, "")
    }

    @Test("画面を閉じたとき") func onDisappear() {
        presenter.onDisappear()
        #expect(true, "")
    }
}
