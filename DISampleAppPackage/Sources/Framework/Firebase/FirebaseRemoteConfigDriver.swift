//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Combine
import DomainLayer
import FirebaseRemoteConfig
import Foundation

public class FirebaseRemoteConfigDriver<T: CacheDataStoreProtocol>: FirebaseRemoteConfigDriverProtocol {
    /// FirebaseApp.configure() 前に Firebase SDK API を呼ばないようにするために lazy var にしている
    private lazy var remoteConfig = {
        // https://firebase.google.com/docs/remote-config/get-started?platform=ios&hl=ja
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        return remoteConfig
    }()

    private let updatedRemoteConfigTypesSubject = PassthroughSubject<[RemoteConfigType], Never>()

    private let cacheDataStore: T

    private var cancellables = Set<AnyCancellable>()

    public init(cacheDataStore: T) {
        LogDriver.initLog()

        self.cacheDataStore = cacheDataStore

        updatedRemoteConfigTypesSubject
            .flatMap { Publishers.Sequence(sequence: $0) }
            .sink { [weak self] updatedRemoteConfigType in
                guard let self else {
                    return
                }
                do {
                    switch updatedRemoteConfigType {
                    case .appInfo:
                        try cacheDataStore.appInfoSubject.send(getValue(remoteConfigType: updatedRemoteConfigType))
                    case .variantTest:
                        try cacheDataStore.variantTestSubject.send(getValue(remoteConfigType: updatedRemoteConfigType))
                    }
                } catch {}
            }
            .store(in: &cancellables)
    }

    deinit {
        LogDriver.deinitLog()
    }

    public func fetchAndActivate() async throws {
        do {
            try setDefaults()
            try await remoteConfig.fetchAndActivate()
        } catch {
            LogDriver.log(.debug(.init(message: "\(error)")))
            throw error
        }

        remoteConfig.addOnConfigUpdateListener { [weak self] updatedRemoteConfig, error in
            guard let self else {
                return
            }

            if let error {
                cacheDataStore.remoteConfigUpdateErrorSubject.send(AppError.customError("\(error)"))
                LogDriver.log(.debug(.init(message: "\(error)")))
                return
            }

            guard let updatedRemoteConfig else {
                LogDriver.log(.debug(.init(message: "Unexpected")))
                cacheDataStore.remoteConfigUpdateErrorSubject.send(AppError.customError("Unexpected"))
                assertionFailure("Unexpected")
                return
            }

            do {
                let remoteConfigTypes = try updatedRemoteConfig.updatedKeys.map { updatedKey in
                    try RemoteConfigType(keyName: updatedKey)
                }
                updatedRemoteConfigTypesSubject.send(remoteConfigTypes)
            } catch {
                LogDriver.log(.debug(.init(message: "\(error)")))
                cacheDataStore.remoteConfigUpdateErrorSubject.send(AppError.customError("\(error)"))
            }
        }
    }

    public func getValue<RemoteConfigurableItem: RemoteConfigurable>(remoteConfigType: RemoteConfigType) throws -> RemoteConfigurableItem {
        do {
            let data = remoteConfig.configValue(forKey: remoteConfigType.keyName).dataValue
            let decoded = try JSONDecoder().decode(RemoteConfigurableItem.self, from: data)
            LogDriver.log(.debug(.init(message: "\(decoded)")))
            return decoded
        } catch {
            LogDriver.log(.debug(.init(message: "\(error)")))
            throw error
        }
    }
}

extension FirebaseRemoteConfigDriver {
    private func setDefaults() throws {
        do {
            try RemoteConfigType.allCases.forEach { remoteConfigType in
                try remoteConfig.setDefaults(from: remoteConfigType.defaultValue)
            }
        } catch {
            LogDriver.log(.debug(.init(message: "\(error)")))
            throw error
        }
    }
}
