//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Combine
import DomainLayer
@preconcurrency import FirebaseRemoteConfig
import Foundation

public final class FirebaseRemoteConfigDriver<CacheDataStore: CacheDataStoreDriverProtocol>: FirebaseRemoteConfigDriverProtocol {
    private let remoteConfig: FirebaseRemoteConfig.RemoteConfig = {
        // https://firebase.google.com/docs/remote-config/get-started?platform=ios
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        return remoteConfig
    }()

    private let updatedRemoteConfigTypesSubject = PassthroughSubject<[RemoteConfigType], Never>()

    private let cacheDataStoreDriver: CacheDataStore

    private var cancellables = Set<AnyCancellable>()

    @MainActor
    public init(cacheDataStoreDriver: CacheDataStore) {
        OSLogDriver.initLog()

        self.cacheDataStoreDriver = cacheDataStoreDriver

        updatedRemoteConfigTypesSubject
            .flatMap { Publishers.Sequence(sequence: $0) }
            .sink { [weak self] updatedRemoteConfigType in
                guard let self else {
                    return
                }
                Task {
                    do {
                        try await self.remoteConfig.activate() // activate しないと最新の Remote Config 上の値を取得できない（fetchでは更新されない）
                        switch updatedRemoteConfigType {
                        case .appInfo:
                            try self.cacheDataStoreDriver.appInfoSubjecter.send(self.getValue(remoteConfigType: updatedRemoteConfigType))
                        case .variantTest:
                            try self.cacheDataStoreDriver.variantTestSubjecter.send(self.getValue(remoteConfigType: updatedRemoteConfigType))
                        }
                    } catch {
                        OSLogDriver.errorLog(error.toAppError)
                    }
                }
            }
            .store(in: &cancellables)
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    @MainActor
    public func setUp() async throws {
        do {
            try setDefaults()
            try await remoteConfig.fetchAndActivate()
            try updateDataStore()
        } catch {
            OSLogDriver.errorLog(error.toAppError)
            throw error
        }

        remoteConfig.addOnConfigUpdateListener { [weak self] updatedRemoteConfig, error in
            guard let self else {
                return
            }

            if let error {
                cacheDataStoreDriver.remoteConfigUpdateErrorSubjecter.send(AppError.customError("\(error)"))
                OSLogDriver.errorLog(error.toAppError)
                return
            }

            guard let updatedRemoteConfig else {
                OSLogDriver.debugLog("Unexpected", level: .fault)
                cacheDataStoreDriver.remoteConfigUpdateErrorSubjecter.send(AppError.customError("Unexpected"))
                assertionFailure("Unexpected")
                return
            }

            do {
                let remoteConfigTypes = try updatedRemoteConfig.updatedKeys.map { updatedKey in
                    try RemoteConfigType(keyName: updatedKey)
                }
                updatedRemoteConfigTypesSubject.send(remoteConfigTypes)
            } catch {
                OSLogDriver.errorLog(error.toAppError)
                cacheDataStoreDriver.remoteConfigUpdateErrorSubjecter.send(AppError.customError("\(error)"))
            }
        }
    }

    private func getValue<RemoteConfigurableItem: RemoteConfigurable>(remoteConfigType: RemoteConfigType) throws -> RemoteConfigurableItem {
        do {
            let data = remoteConfig.configValue(forKey: remoteConfigType.keyName).dataValue
            let decoded = try JSONDecoder().decode(RemoteConfigurableItem.self, from: data)
            OSLogDriver.debugLog("\(decoded)")
            return decoded
        } catch {
            OSLogDriver.errorLog(error.toAppError)
            throw error
        }
    }

    private func updateDataStore() throws {
        do {
            try RemoteConfigType.allCases.forEach { remoteConfigType in
                switch remoteConfigType {
                case .appInfo:
                    try cacheDataStoreDriver.appInfoSubjecter.send(getValue(remoteConfigType: remoteConfigType))
                case .variantTest:
                    try cacheDataStoreDriver.variantTestSubjecter.send(getValue(remoteConfigType: remoteConfigType))
                }
            }
        } catch {
            OSLogDriver.errorLog(error.toAppError)
            throw error
        }
    }

    private func setDefaults() throws {
        do {
            try RemoteConfigType.allCases.forEach { remoteConfigType in
                try remoteConfig.setDefaults(from: remoteConfigType.defaultValue)
            }
        } catch {
            OSLogDriver.errorLog(error.toAppError)
            throw error
        }
    }
}
