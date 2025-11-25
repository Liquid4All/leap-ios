// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "LeapSDK",
  platforms: [
    .iOS(.v15),
    .macOS(.v12),
    .macCatalyst(.v15),
  ],
  products: [
    .library(
      name: "LeapSDK",
      targets: ["LeapSDK", "LeapSDKSupport", "LeapSDKMacros"]
    ),
    .library(
      name: "LeapModelDownloader",
      targets: ["LeapModelDownloader"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0")
  ],
  targets: [
    .binaryTarget(
      name: "LeapSDK",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.6/LeapSDK.xcframework.zip", checksum: "0f52a8c7e17c2b181019ff041b0689508818494c5504706d9bba4d916fb6feb4"
    ),
    .binaryTarget(
      name: "InferenceEngine",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.6/inference_engine.xcframework.zip", checksum: "78d5269997f0bea733c8fbdd122d796ab4eb73b33c0038eca55af32b3c0808f8"
    ),
    .binaryTarget(
      name: "InferenceEngineExecutorchBackend",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.6/inference_engine_executorch_backend.xcframework.zip", checksum: "97c0e590a86b36fd9074136e49f92772aec40b827e47924b25207fb5e6fba61e"
    ),
    .binaryTarget(
      name: "InferenceEngineLlamaCppBackend",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.6/inference_engine_llamacpp_backend.xcframework.zip", checksum: "6768fa4516e145ec2e8ac78dffea7c3e5249ed2fe7637014696dee351bc4475b"
    ),
    .binaryTarget(
      name: "LeapModelDownloader",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.6/LeapModelDownloader.xcframework.zip", checksum: "8c424ea225528c7a8887b52a34605bf6220dce04ca0ec736a7255cbb51fa2963"
    ),
    .target(
      name: "LeapSDKSupport",
      dependencies: [
        "InferenceEngine",
        "InferenceEngineExecutorchBackend",
        "InferenceEngineLlamaCppBackend",
      ],
      path: "Sources/LeapSDKSupport"
    ),
    .target(
      name: "LeapSDKMacros",
      dependencies: [
        "LeapSDK",
        "LeapSDKConstrainedGenerationPlugin",
      ],
      path: "Sources/LeapSDKMacros"
    ),
    .macro(
      name: "LeapSDKConstrainedGenerationPlugin",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
      ],
      path: "Sources/LeapSDKConstrainedGenerationPlugin"
    ),
  ]
)
