//
//  Created by sugurutakahashi on 2024/03/05
//  Copyright sugurutakahashi. All rights reserved.
//

import PackagePlugin



@main
struct MockoloRunPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        [
            ._prebuildCommand(
                displayName: "Generating Mocks with Mockolo",
                executable: Path("/usr/bin/make"),
                arguments: [
                    "mockolo-run"
                ],
                workingDirectory: Path("\(context.package.directory)/../"), // ここに設定するか args で "-C", "\(context.package.directory)/../" を指定する
                outputFilesDirectory: Path("\(context.package.directory)/../DISampleAppPackage/Sources/Presentation/Domain/Mocks.swift") // 多分不要である
            ),
        ]
    }
}
