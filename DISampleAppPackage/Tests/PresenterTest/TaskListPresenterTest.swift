
import DomainLayer
import Foundation
@testable import PresentationLayer
import Testing

@MainActor
struct TaskListPresenterTest {
    var presenter: TaskListPresenter<AppRootRouterDependencyMock>!
    var dependencyInjector: AppRootRouterDependencyMock!

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

    @Test("Firebase Remoto Config によって新実装モードがONになったとき") func isEnabledNewFeatureTrue() async {
        #expect(presenter.isEnabledNewFeature == false, "新実装モードがONになること（前提条件の確認）")
        dependencyInjector.cacheDataStore.variantTestSubjecter.send(.init(isEnabledNewFeature: true))
        try! await Task.sleep(nanoseconds: 500_000_000) // Combine による非同期処理なので 0.5 秒待たせているが swift-testing でもっとスマートにかけるかもしれない
        #expect(presenter.isEnabledNewFeature == true, "新実装モードがONになること")
    }

    @Test("Firebase Remoto Config によって新実装モードがOFFになったとき") func isEnabledNewFeatureFalse() {
        #expect(presenter.isEnabledNewFeature == false, "新実装モードがOFFになること（前提条件の確認）")
        dependencyInjector.cacheDataStore.variantTestSubjecter.send(.init(isEnabledNewFeature: false))
        #expect(presenter.isEnabledNewFeature == false, "新実装モードがOFFになること")
    }
}
