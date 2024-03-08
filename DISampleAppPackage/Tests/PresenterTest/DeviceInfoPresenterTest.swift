
import DomainLayer
@testable import PresentationLayer
import SwiftUI // for UIPasteboard
import Testing

/// テストモックは Computed property にするとインスタンスが保持されず、Mock のカウントによるテストがうまく動作しないので注意
struct DeviceInfoPresenterDependencyTestMock: DeviceInfoPresenterDependency {
    var deviceInfoDriver: DeviceInfoDriverProtocolMock = .init()
    var buildEnvDriver: BuildEnvDriverProtocolMock = .init(buildScheme: .random, buildConfiguration: .random)

    /// テスト時に本物の ClipboardDriver を使ってしまうとペースト許諾のアラートが表示されてテストが実行されないため、Mockに差し替えています
    var clipboardDriver: ClipboardDriverProtocolMock = .init()
}

@MainActor
struct DeviceInfoPresenterTest {
    var presenter: DeviceInfoPresenter<DeviceInfoPresenterDependencyTestMock>!
    var dependencyInjector: DeviceInfoPresenterDependencyTestMock!
    var deviceInfoType: DeviceInfoType!

    init() {
        deviceInfoType = .random
        dependencyInjector = .init()
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

    @Test("デバイス情報をタップしたとき") func onTapDeviceInfo() {
        presenter.onTapDeviceInfo(deviceInfoType)
        #expect(presenter.selectedDeviceInfoType == deviceInfoType, "タップしたデバイス情報が選択されること")
        #expect(dependencyInjector.clipboardDriver.copyCallCount == 1, "タップしたデバイス情報がクリップボードにコピーされること")
        #expect(presenter.shouldShowCopyAlert == true, "コピーした際のアラートが表示されること")
    }
}
