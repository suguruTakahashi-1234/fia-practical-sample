//
//  Created by sugurutakahashi on 2024/03/11
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

/// ここで使われる Driver は DependencyInjector 内でのみ使用されるため、本来必要のない protocol であるが、internal な範囲で使用することを明確化するためにあえて定義している（mockable のアノテーションをつけることは生成される Mock ファイルが Presentation 層なのでできない）
protocol AppRootDependencyInjectorDependency {
    associatedtype DeviceNameDriverProtocolAT = DeviceNameDriverProtocol
    associatedtype FirebaseLogDriverProtocolAT: FirebaseLogDriverProtocol
    associatedtype FirebaseSetupDriverProtocolAT: FirebaseSetupDriverProtocol
    associatedtype FirebaseRemoteConfigDriverProtocolAT: FirebaseRemoteConfigDriverProtocol

    var deviceNameDriver: DeviceNameDriverProtocolAT { get }
    var firebaseLogDriver: FirebaseLogDriverProtocolAT { get }
    var firebaseSetupDriver: FirebaseSetupDriverProtocolAT { get }
    var firebaseRemoteConfigDriver: FirebaseRemoteConfigDriverProtocolAT { get }
}
