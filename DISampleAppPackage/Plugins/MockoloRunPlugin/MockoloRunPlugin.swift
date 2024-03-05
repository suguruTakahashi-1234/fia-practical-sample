//
//  Created by sugurutakahashi on 2024/03/05
//  Copyright sugurutakahashi. All rights reserved.
//

import PackagePlugin

@main
struct MockoloRunPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        [
            .prebuildCommand(
                displayName: "Generating Mocks with Mockolo",
                executable: Path("/usr/bin/make"),
                arguments: [
                    "mockolo-run",
                    "-C", "\(context.package.directory)/../"
                ],
                outputFilesDirectory: Path("\(context.package.directory)/../DISampleAppPackage/Sources/Presentation/Domain/Mocks.swift")
          ),
        ]
    }
}
