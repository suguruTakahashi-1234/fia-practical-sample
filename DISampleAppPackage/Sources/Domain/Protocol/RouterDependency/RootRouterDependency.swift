//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol RootRouterDependency {
    var osLogDriver: OSLogDriverProtocol { get }
    var firebaseSetupDriver: FirebaseSetupDriverProtocol { get }
    var libraryLicenseDriver: LibraryLicenseDriverProtocol { get }
}
