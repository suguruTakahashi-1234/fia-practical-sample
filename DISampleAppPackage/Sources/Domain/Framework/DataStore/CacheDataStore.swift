//
//  Created by sugurutakahashi on 2024/03/08
//  Copyright sugurutakahashi. All rights reserved.
//

import Combine

public actor CacheDataStore: CacheDataStoreProtocol {
    public let remoteConfigUpdateErrorSubject = PassthroughSubject<AppError, Never>()
    public let appInfoSubject = PassthroughSubject<AppInfo, Never>()
    public let variantTestSubject = PassthroughSubject<VariantTest, Never>()

    public init() {
        LogDriver.initLog()
    }
}
