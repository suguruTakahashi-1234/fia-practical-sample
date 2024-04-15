
日本語 | [English](./README.en.md)

# FIDA Sample App

このリポジトリは Swift で実装する iOS アプリの設計に [Framework-Independent Development Architecture (FIDA)](#framework-independent-development-architecture-fida) を適応したサンプルアプリになります。

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

- アーキテクチャ
  - Clean Architecture の設計概念の適応
  - Swfit Package Manager によるマルチモジュール構成
- テスト
  - [swift-testing](https://github.com/apple/swift-testing) によるテストコードの記述
  - [Mockolo](https://github.com/uber/mockolo) でのテスト用 Mock の自動生成
  - [PreviewSnapshots](https://github.com/doordash-oss/swiftui-preview-snapshots) による SwiftUI Previews のスナップショットテスト
  - TestPlan による多言語テスト対応
  - XCUITest による UI テスト
- Swift 6 対応
  - Swift Concurrency Cheacking の Complete 対応
  - protocol の `any` / `some` 対応
    - `any protocol` は使わず、すべて `some protocol` として実装
- 新しい技術への挑戦
  - [Observation](https://developer.apple.com/documentation/observation) による Data Binding
  - [String Catalogs](https://developer.apple.com/documentation/xcode/localizing-and-varying-text-with-a-string-catalog) による多言語対応
- 開発体験向上
  - Xcode Cloud による CI/CD
  - [Sourcery](https://github.com/krzysztofzablocki/Sourcery) によるボイラープレートコードの自動生成
  - [Periphery](https://github.com/peripheryapp/periphery) による不要なコードの静的解析
  - [Renovate](https://github.com/renovatebot/renovate) によるライブラリのアップデートの管理（[ダッシュボード Issue](https://github.com/suguruTakahashi-1234/DISample/issues/38)）
  - [Swift-DocC](https://www.swift.org/documentation/docc/) による Documentation as Code の取り組み
  - GitHub Actions による [Swift-DocC](https://www.swift.org/documentation/docc/) の Hosting
- ライブラリ管理
  - Swfit Package Manager
  - [Mint](https://github.com/yonaskolb/Mint) (Swfit Package Manager 経由での導入)

## はじめ方

#### Clone Repository

```shell
$ git clone https://github.com/suguruTakahashi-1234/DISample.git
$ cd DISample
```

#### セットアップ

以下の `make setup`コマンドを実行すると、[Mint](https://github.com/yonaskolb/Mint) と[githooks](https://git-scm.com/docs/githooks) の設定が適用され、`.xcworkspace`を開いて Xcode が起動されます。

```shell
$ make setup
```

`make setup` が実行するプロセスは [Makefile](./Makefile) に記述されており、`make help` を実行することで、定義されてある make コマンドのリストが表示されます。

## アーキテクチャ

[Framework-Independent Development Architecture (FIDA)](#framework-independent-development-architecture-FIDA) とは Clean Architecture の設計概念を元に、Swift Package Manager によるマルチモジュール構成でレイヤーごとにモジュールを分割して、適切な依存方向を定めることで、サードパーティー製ライブラリを含んだフレームワーク層に依存しない形で、プレゼンテーション層およびアプリケーション層のテストを実現することを目的としてアーキテクチャになります。

上記のような Clean Architecture を採用するメリットに加えて、フレームワーク層に依存しないクリーンな層では高速なビルドが可能になり、これは Xcode でのビルドを何度も繰り返す iOS エンジニアにとって、非常に大きな開発体験の向上に繋がります。

### モチベーション

Swfit Package Manager の登場によって、[isowords](https://github.com/pointfreeco/isowords) のように自身のアプリケーションを容易にマルチモジュール構成にすることができるようになりました。

一般的な Swfit Package Manager のモジュールの分割は、共通処理モジュール（Core、Common など）+ 機能（Feature）モジュール（LoginFeature、SettingFeature など）での分割になりますが、このアプリケーションでは、レイヤー単位でモジュールを分割を採用しております。

モジュールの依存関係を `Package.Swift` に記述することで管理できる Swfit Package Manager は、依存の方向が重要となる Clean Architecture ととても相性がよいです。

さらに Clean Architecture の概念を適応させることで、サードパーティー製のライブラリや、外部の API との疎通の処理をモックに差し替える仕組み（依存性の注入）によって、各レイヤーのテストコードが記述しやすくなります。

以下は、このプロジェクトで定義しているテストの種類と、そのテストによって担保されるテスト対象を示した表になります。

| テストの種類              |    Driver     | テスト対象: |      |           |            |                  |
| ------------------------- | :-----------: | :---------: | :--: | :-------: | :--------: | :--------------: |
|                           |               |   Router    | View | Presenter | Interactor |      Driver      |
| App UI テスト (XCUITest)  | Actual / Mock |      ◎      |  ◯   |     ◯     |     ◯      | ◯ / - |
| スナップショットテスト    |     Mock      |      -      |  ◎   |     ◯     |     ◯      |        -         |
| Presenter ユニットテスト  |     Mock      |      -      |  -   |     ◎     |     ◯      |        -         |
| Interactor ユニットテスト | Actual / Mock |      -      |  -   |     -     |     ◎      | ◯ / - |
| Driver ユニットテスト     |    Actual     |      -      |  -   |     -     |     -      |        ◎         |

※ ◎ : テスト対象、◯ : 付随的にテストされる対象

この表を念頭に置くことで、各テストで担保しなければならない範囲が明確になり、記述するテストコードの価値を高めることに繋がります。

App UI テスト (XCUITest) と Interactor のテストでは、実際（Actual）の Dirver を使った場合と Mock の Dirver を使った場合の両方を定義してい
その比較を行うシチュエーションとしては、API を疎通する画面で不具合が生じた時に、それがアプリ側の原因なのか、API側の原因なのかの、原因切り分けに使うことができ

### Framework-Independent Development Architecture (FIDA)

Framework-Independent Development Architecture (FIDA) は、ソフトウェア・アプリケーションのコンポーネント間の明確な関心の分離を実現するように設計されています。これは、以下のような特定の役割を持つ明確なレイヤーにコードを編成することで達成されます：

- **Domain Layer**: 
  - **Entity**: 
  - **DriverProtocol**: 
  - **UseCase**: 
- **Presentation Layer**: 
  - **Interactor**: 
  - **Presenter**: 
  - **View**: 
  - **Router**: 
  - **MockDriver**: 
  - **xxxDependency**:
  - **MockDependencyInjector**: 
- **Framework Layer**: 
  - **Driver**: 
- **Third Party Layer**:
  - **Third Party Library**:
- **DI Layer**:
  - **DependencyInjector**: 
- **App Layer**: アプリのエントリーポイント
  - **Development**: 
  - **Production**: 

FIDAでは、各レイヤーは独立しており、交換可能であるため、フレームワークや外部依存関係から切り離して各部をテストすることができる。

<div align="center">
<img src="./asset/drawio/architecture_outline.drawio.svg"/>
</div>

<div align="center">
<img src="./asset/drawio/architecture_circle.drawio.svg"/>
</div>

<div align="center">
<img src="./asset/drawio/architecture_detail.drawio.svg"/>
</div>

### Advantages and Disadvantages of FIDA

このセクションでは、ソフトウェア開発におけるFIDAの採用の利点と欠点について議論します。

#### メリット

- テスト可能性：関心の分離が明確でフレームワークからの分離があるため、コードの単位を独立してテストすることができ、包括的な単体テストとTDD（テスト駆動開発）を容易にします。
- 保守性：一つの層での変更が他の層に影響を与えないことが多く、コードベースの保守と進化を容易にします。
- 柔軟性：フレームワークに依存しない設計により、ニーズの変化や新しい技術の出現に伴って異なるフレームワークや技術への移行が容易になります。
- スケーラビリティ：各層を独立してスケールアウトできるため、ターゲットとする最適化が可能になります。

#### デメリット

- 複雑性：複数の層と抽象化により、アーキテクチャが追加の複雑さをもたらすことがあり、これは単純なアプリケーションには過剰かもしれません。
- 学習曲線：開発者はアーキテクチャに慣れ、層間の相互作用を理解するために時間がかかるかもしれません。
- 開発時間：層間でのインターフェイスの定義と依存性注入メカニズムの設定が必要なため、アプリケーションの設定と開発に時間がかかることがあります。

### Swift Package Manager Dependencies Diagrams

By executing the following make command, Mermaid files for Swift Package Manager dependencies will be generated (by [depermaid](https://github.com/daikimat/depermaid), [mermaid-cli](https://github.com/mermaid-js/mermaid-cli)).

```shell
$ make spm-dependencies-mermaid-gen
```

#### My Targets

![My Targets Diagram](./asset/image/my_targets.svg)

#### Including Test Targets

![Including Test Targets](./asset/image/test_targets.svg)

#### Including Library

![Including Library](./asset/image/library_targets.svg)

#### Including All

![Including All](./asset/image/all_targets.svg)

## CI/CD

### Xcode Cloud

Please check Xcode Cloud settings via Xcode or [App Store Connect](https://appstoreconnect.apple.com/).

Currently, Xcode Cloud configuration supports only GUI operations, and configuration files cannot be exported or managed via GitHub.

### GitHub Actions

- [Host Swift-DocC](https://github.com/suguruTakahashi-1234/DISample/actions/workflows/swift_docc_hosting.yml)
- [Generate Tag & Release Note](https://github.com/suguruTakahashi-1234/DISample/actions/workflows/tag_and_release_note_gen.yml)

## Documents

- [Swift-DocC](https://sugurutakahashi-1234.github.io/DISample/documentation/domainlayer/) (Only DomainLayer)

## Contributing

[![GitHub contributors](https://img.shields.io/github/contributors/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/graphs/contributors)

Thank you for your interest in contributing! 🌟

Please check out our [CONTRIBUTING](./CONTRIBUTING.md) and [CODE_OF_CONDUCT](./CODE_OF_CONDUCT.md) for guidelines on how to contribute.

## License

[![GitHub license](https://img.shields.io/github/license/suguruTakahashi-1234/DISample)](https://github.com/suguruTakahashi-1234/DISample/blob/main/LICENSE.md)

See the [LICENSE](./LICENSE.md) file for license rights and limitations (MIT).

## Contact

[![X URL](https://img.shields.io/twitter/url?url=https%3A%2F%2Ftwitter.com%2Fikuraikuraaaaaa)](https://twitter.com/ikuraikuraaaaaa)
