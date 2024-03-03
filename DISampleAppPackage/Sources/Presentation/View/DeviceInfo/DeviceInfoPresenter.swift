
import DomainLayer
import Foundation
import SwiftUI // for UIPasteboard

/// @mockable
public protocol BuildEnvRepositoryProtocol: AnyObject {
    var buildScheme: BuildScheme { get }
    var buildConfiguration: BuildConfiguration { get }
}

public final class BuildEnvRepository: BuildEnvRepositoryProtocol {
    public let buildScheme: BuildScheme
    public let buildConfiguration: BuildConfiguration
    
    public init(buildScheme: BuildScheme) {
        self.buildScheme = buildScheme

        #if DEBUG
            buildConfiguration = .debug
        #else
            buildConfiguration = .release
        #endif
    }
}

public extension BuildEnvRepositoryProtocol {
    var isStaging: Bool {
        buildScheme == .staging
    }

    var isProduction: Bool {
        buildScheme == .production
    }

    var isDebug: Bool {
        buildConfiguration == .debug
    }

    var isRelease: Bool {
        buildConfiguration == .release
    }
    
    var isStagingDebug: Bool {
        buildScheme == .staging && buildConfiguration == .debug
    }

    var isStagingRelease: Bool {
        buildScheme == .staging && buildConfiguration == .release
    }

    var isProductionDebug: Bool {
        buildScheme == .production && buildConfiguration == .debug
    }

    var isProductionRelease: Bool {
        buildScheme == .production && buildConfiguration == .release
    }
}


@MainActor
final class DeviceInfoPresenter<Dependency: DeviceInfoPresenterDependency>: ObservableObject {
    @Published var shouldShowCopyAlert: Bool = false
    private(set) var selectedDeviceInfoType: DeviceInfoType?

    private let deviceInfoDriver: Dependency.DeviceInfoDriverProtocolAT
    private let buildEnvRepository: Dependency.BuildEnvRepositoryProtocolAT
    
    var copiedAlertTitle: String {
        guard let selectedDeviceInfoType else {
            return ""
        }
        return "Copied \"\(getDeviceInfoValue(selectedDeviceInfoType))\""
    }

    init(dependency: Dependency) {
        LoggerContainer.initLog()
        
        deviceInfoDriver = dependency.deviceInfoDriver
        buildEnvRepository = dependency.buildEnvRepository
    }

    deinit {
        LoggerContainer.deinitLog()
    }

    func onAppear() async {
        LoggerContainer.logOnAppear()
    }

    func onDisappear() {
        LoggerContainer.logOnDisappear()
    }
    
    func onTapDeviceInfo(_ debugInfoType: DeviceInfoType) {
        selectedDeviceInfoType = debugInfoType
        UIPasteboard.general.string = getDeviceInfoValue(debugInfoType)
        shouldShowCopyAlert = true
    }
    
    func getDeviceInfoValue(_ deviceInfoType: DeviceInfoType) -> String {
        switch deviceInfoType {
        case .appVersion:
            return "\(deviceInfoDriver.appVersion) (\(deviceInfoDriver.appBuildNumber))"
        case .buildScheme:
            return buildEnvRepository.buildScheme.name
        case .buildConfiguration:
            return buildEnvRepository.buildConfiguration.name
        case .deviceIdentifier:
            return deviceInfoDriver.deviceIdentifier
        case .deviceName:
            return deviceInfoDriver.deviceName
        case .isSimulator:
            return "\(deviceInfoDriver.isSimulator)"
        case .osVersion:
            return "\(deviceInfoDriver.osType) \(deviceInfoDriver.osVersion)"
        case .timezone:
            return TimeZone.current.identifier
        case .language:
            return Locale.current.language.languageCode?.identifier ?? "unknown"
        case .uiUserInterfaceStyle:
            return "\(deviceInfoDriver.uiUserInterfaceStyle.rawValue)"
        case .uiContentSize:
            return "\(deviceInfoDriver.uiContentSizeCategory.rawValue)"
        }
    }
}

private extension BuildScheme {
    var name: String {
        "\(self)".camelCaseToSpaces.localizedCapitalized
    }
}

private extension BuildConfiguration {
    var name: String {
        "\(self)".camelCaseToSpaces.localizedCapitalized
    }
}
