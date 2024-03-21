//
//  Created by sugurutakahashi on 2024/03/11
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

/// ここで使われる Driver は DependencyInjector 内でのみ使用されるため、本来必要のない protocol であるが、internal な範囲で使用することを明確化するためにあえて定義している
/// mockable のアノテーションをつけることで生成される Mock ファイルが Presentation 層のため、依存の関係上 mockable とすることはできない
/// periphery:ignore
protocol AppRootDependencyInjectorDependency: AnyObject {
    associatedtype DeviceNameDriverProtocolAT = DeviceNameDriverProtocol
    associatedtype FirebaseSetupDriverProtocolAT: FirebaseSetupDriverProtocol
    associatedtype FirebaseRemoteConfigDriverProtocolAT: FirebaseRemoteConfigDriverProtocol

    var deviceNameDriver: DeviceNameDriverProtocolAT { get }
    var firebaseSetupDriver: FirebaseSetupDriverProtocolAT { get }
    var firebaseRemoteConfigDriver: FirebaseRemoteConfigDriverProtocolAT { get }
}
