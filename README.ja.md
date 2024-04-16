
[English](./README.md) | 日本語

# FIA Sample App

このリポジトリは、Swift で実装された iOS アプリの設計に、Clean Architecture の設計概念に基づく [Framework-Independent Architecture (FIA)](https://github.com/suguruTakahashi-1234/framework-independent-architecture) を適用したサンプルアプリです。

#### Repository About
[![GitHub license](https://img.shields.io/github/license/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/blob/main/LICENSE.md)
[![GitHub Repo stars](https://img.shields.io/github/stars/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/stargazers)
[![GitHub watchers](https://img.shields.io/github/watchers/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/watchers)
[![GitHub forks](https://img.shields.io/github/forks/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/network/members)
[![GitHub contributors](https://img.shields.io/github/contributors/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/graphs/contributors)
[![Github Created At](https://img.shields.io/github/created-at/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/releases)
[![GitHub top language](https://img.shields.io/github/languages/top/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample)
[![GitHub repo size](https://img.shields.io/github/repo-size/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample)

#### Issue & PR

[![GitHub issues](https://img.shields.io/github/issues-raw/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr-raw/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/pulls)
[![GitHub closed issues](https://img.shields.io/github/issues-closed-raw/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/issues?q=is%3Aissue+is%3Aclosed)
[![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed-raw/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/pulls?q=is%3Apr+is%3Aclosed)

#### Release & Tag

[![GitHub Tag](https://img.shields.io/github/v/tag/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/tags)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/releases)
[![GitHub Release Date](https://img.shields.io/github/release-date/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/releases)
[![GitHub commits since latest release](https://img.shields.io/github/commits-since/suguruTakahashi-1234/DISample/latest)](https://github.com/suguruTakahashi-1234/DISample)

#### Commit Activity

[![GitHub last commit](https://img.shields.io/github/last-commit/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/commits)
[![GitHub commit activity (Week)](https://img.shields.io/github/commit-activity/w/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample)
[![GitHub commit activity (Month)](https://img.shields.io/github/commit-activity/m/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample)
[![GitHub commit activity (Year)](https://img.shields.io/github/commit-activity/y/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample)
[![GitHub commit activity (Total)](https://img.shields.io/github/commit-activity/t/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/commits)

#### Workflow Status

[![GitHub Actions Workflow Status (tag_and_release_note_gen.yml)](https://img.shields.io/github/actions/workflow/status/suguruTakahashi-1234/DISample/tag_and_release_note_gen.yml)](https://github.com/suguruTakahashi-1234/DISample/actions/workflows/tag_and_release_note_gen.yml)
[![GitHub Actions Workflow Status (swift_docc_hosting.yml)](https://img.shields.io/github/actions/workflow/status/suguruTakahashi-1234/DISample/swift_docc_hosting.yml)](https://github.com/suguruTakahashi-1234/DISample/actions/workflows/swift_docc_hosting.yml)

## 開発

### 必要条件

![macOS](https://img.shields.io/badge/macOS-14.4.1+-brightgreen?logo=macos)
![Xcode](https://img.shields.io/badge/Xcode-15.3-brightgreen?logo=xcode)
![Swift](https://img.shields.io/badge/Swift-5.10-brightgreen?logo=swift)
![npm](https://img.shields.io/badge/npm-10.5.0+-brightgreen?logo=npm)

- macOS
  - 14.4.1 or Later
- Xcode
  - 15.3 or Later, with Swift 5.10
  - Download from [Xcode Releases](https://xcodereleases.com)
- npm
  - 10.5.1 or Later
  - Install using your preferred method, e.g., [nodebrew](https://github.com/hokaccha/nodebrew)
  - Used to run npx [mermaid-cli](https://github.com/mermaid-js/mermaid-cli)

### サポートするプラットフォーム

![Supported Platform (iOS)](https://img.shields.io/badge/iOS-17.4+-brightgreen)
![Supported Platform (iPad)](https://img.shields.io/badge/iPadOS-17.4+-brightgreen)

- iOS
  - 17.4 or Later
- iPadOS
  - 17.4 or Later

### サポートする言語

- Japanese (default)
- English

### 技術要素

- **アーキテクチャ**
  -  Clean Architecture の設計概念をベースにした [Framework-Independent Architecture (FIA)](https://github.com/suguruTakahashi-1234/framework-independent-architecture) の適応
  - Swfit Package Manager によるマルチモジュール、マルチプロジェクト構成
- **テスト**
  - [swift-testing](https://github.com/apple/swift-testing) によるテストコードの記述
  - [Mockolo](https://github.com/uber/mockolo) でのテスト用 Mock の自動生成
  - [PreviewSnapshots](https://github.com/doordash-oss/swiftui-preview-snapshots) による SwiftUI Previews のスナップショットテスト
  - TestPlan による多言語テスト対応
  - XCUITest による UI テスト
- **Swift 6 対応**
  - Swift Concurrency Cheacking の Complete 対応
  - protocol の `any` / `some` 対応
    - `any protocol` は使わず、すべて `some protocol` として実装
- **新しい技術への挑戦**
  - [Observation](https://developer.apple.com/documentation/observation) による Data Binding
  - [String Catalogs](https://developer.apple.com/documentation/xcode/localizing-and-varying-text-with-a-string-catalog) による多言語対応
- **開発体験向上**
  - Xcode Cloud による CI/CD
  - [Sourcery](https://github.com/krzysztofzablocki/Sourcery) によるボイラープレートコードの自動生成
  - [Periphery](https://github.com/peripheryapp/periphery) による不要なコードの静的解析
  - [Renovate](https://github.com/renovatebot/renovate) によるライブラリのアップデートの管理（[ダッシュボード Issue](https://github.com/suguruTakahashi-1234/DISample/issues/38)）
  - [Swift-DocC](https://www.swift.org/documentation/docc/) による Documentation as Code の取り組み
  - GitHub Actions による [Swift-DocC](https://www.swift.org/documentation/docc/) の Hosting
- **ライブラリ管理**
  - Swfit Package Manager
  - [Mint](https://github.com/yonaskolb/Mint) (Swfit Package Manager 経由での導入)

## はじめ方

### Clone Repository

```shell
$ git clone https://github.com/suguruTakahashi-1234/DISample.git
$ cd DISample
```

### セットアップ

以下の `make setup`コマンドを実行すると、[Mint](https://github.com/yonaskolb/Mint) と [githooks](https://git-scm.com/docs/githooks) の設定が適用され、`.xcworkspace`を開いて Xcode が起動されます。

```shell
$ make setup
```

`make setup` が実行するプロセスは [Makefile](./Makefile) に記述されており、`make help` を実行することで、定義されてある make コマンドのリストが表示されます。

## Swift Package Manager Dependencies Diagrams

以下の make コマンドを実行することで、Swift Package Manager の依存関係を示す Mermaid ファイルが生成されます (by [depermaid](https://github.com/daikimat/depermaid), [mermaid-cli](https://github.com/mermaid-js/mermaid-cli))。

```shell
$ make spm-dependencies-mermaid-gen
```

生成された Mermaid は以下の通りです。

### My Targets

![My Targets Diagram](./asset/image/my_targets.svg)

### Including Test Targets

![Including Test Targets](./asset/image/test_targets.svg)

### Including Library

![Including Library](./asset/image/library_targets.svg)

### Including All

![Including All](./asset/image/all_targets.svg)

## CI/CD

### Xcode Cloud

このプロジェクトの CI/CD 環境は Xcode Cloud によって構築されています。

現在、Xcode Cloud の設定は GUI 操作のみが公式にサポートされており、設定ファイルのエクスポートや GitHub 経由での管理をしておりません。

### GitHub Actions

このプロジェクトでは以下のような開発を補助する GitHub Actions が設定されています。

- [Host Swift-DocC](https://github.com/suguruTakahashi-1234/DISample/actions/workflows/swift_docc_hosting.yml)
- [Generate Tag & Release Note](https://github.com/suguruTakahashi-1234/DISample/actions/workflows/tag_and_release_note_gen.yml)

## Documents

[Host Swift-DocC](https://github.com/suguruTakahashi-1234/DISample/actions/workflows/swift_docc_hosting.yml) の GitHub Actions によって、以下のリンクにドメイン層のコードの Swift-DocC をホスティングしています。

- [DomainLayer](https://sugurutakahashi-1234.github.io/DISample/documentation/domainlayer/)

## Contributing

[![GitHub contributors](https://img.shields.io/github/contributors/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/graphs/contributors)

コントリビュートに関心を持っていただきありがとうございます！ 🌟

コントリビュートの方法については [CONTRIBUTING](./CONTRIBUTING.md) および [CODE_OF_CONDUCT](./CODE_OF_CONDUCT.md) をご覧ください。

## License

[![GitHub license](https://img.shields.io/github/license/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/blob/main/LICENSE.md)

ライセンスの権利と制限については [LICENSE](./LICENSE.md) ファイルをご覧ください（MIT）。

## Contact

[![X URL](https://img.shields.io/twitter/url?url=https%3A%2F%2Ftwitter.com%2Fikuraikuraaaaaa)](https://twitter.com/ikuraikuraaaaaa)
