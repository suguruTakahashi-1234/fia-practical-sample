//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable
public protocol FirebaseRemoteConfigDriverProtocol: AnyObject {
    func fetchAndActivate() async throws

    func getValue<T: RemoteConfigurable>(remoteConfigType: RemoteConfigType) throws -> T
}
