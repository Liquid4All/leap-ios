# LeapSDK for iOS

[![Platform](https://img.shields.io/badge/platform-iOS%20|%20macOS%20|%20Mac%20Catalyst-lightgrey.svg)](https://github.com/Liquid4All/leap-ios)
[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![SPM](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![CocoaPods](https://img.shields.io/badge/CocoaPods-Compatible-red.svg)](https://cocoapods.org/)

LeapSDK is a powerful iOS SDK that enables running AI models locally on device using the Liquid Inference Engine. It provides a high-level Swift API for chat functionality with real-time token streaming.

## Features

- 🚀 **On-device AI inference** - Run models locally without network dependencies
- 💬 **Streaming chat API** - Real-time token streaming with AsyncStream
- 🎯 **Protocol-oriented design** - Clean, extensible architecture
- 📱 **Multi-platform support** - iOS, macOS, and Mac Catalyst
- 🛡️ **Type-safe Swift API** - Modern Swift with full Codable support

## Requirements

- iOS 18.0+ / macOS 14.0+

## Installation

### Swift Package Manager (Recommended)

Add LeapSDK to your project in Xcode:

1. Open your project in Xcode
2. Go to **File → Add Package Dependencies**
3. Enter the repository URL: `https://github.com/Liquid4All/leap-ios.git`
4. Select the latest version and add to your target

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Liquid4All/leap-ios.git", from: "0.7.7")
]
```

### CocoaPods

Add LeapSDK to your `Podfile`:

```ruby
pod 'Leap-SDK', '~> 0.7.7'
```

Then run:

```bash
pod install
```

### Manual Installation

1. Download the latest `LeapSDK.xcframework.zip` from [Releases](https://github.com/Liquid4All/leap-ios/releases)
2. Unzip and drag `LeapSDK.xcframework` into your Xcode project
3. Ensure **"Embed & Sign"** is selected in the frameworks settings

## Quick Start

```swift
import LeapSDK

// Load a model
let modelURL = Bundle.main.url(forResource: "model", withExtension: "bundle")!
let runner = try await Leap.load(options: .init(bundlePath: modelURL.path()))

// Create a conversation
let conversation = Conversation(modelRunner: runner, history: [])

// Generate streaming response
let userMessage = ChatMessage(role: .user, content: [.text("Hello!")])
for await response in conversation.generateResponse(message: userMessage) {
    switch response {
    case .chunk(let text):
        print(text, terminator: "")
    case .reasoningChunk(let reasoning):
        print("Reasoning: \(reasoning)")
    case .complete(let usage, let reason):
        print("\\nComplete! Usage: \(usage)")
    }
}
```

## Documentation

- [Quick Start Guide](https://leap.liquid.ai/docs/ios/ios-quick-start-guide)
- [API Reference](https://leap.liquid.ai/docs/ios/ios-api-spec)
- [Model Library](https://leap.liquid.ai/models)

## Model Bundles

Download pre-trained model bundles from the [Leap Model Library](https://leap.liquid.ai/models). Models are distributed as `.bundle` files that can be included in your app bundle.

## Examples

Complete example applications are available in the [Examples](https://github.com/Liquid4All/leap-ios/tree/main/Examples) directory:

- **LeapChatExample**: SwiftUI chat interface with streaming responses
- **LeapSloganExample**: Simple text generation app

## Performance

- **On-device inference**: No network required, works offline
- **Optimized for mobile**: Efficient memory usage and battery life
- **Real-time streaming**: Token-by-token generation for responsive UIs
- **Multi-platform**: Native performance on iOS, macOS, and Mac Catalyst

## Support

- **Issues**: [GitHub Issues](https://github.com/Liquid4All/leap-ios/issues)
- **Documentation**: [leap.liquid.ai](https://leap.liquid.ai)

## License

LeapSDK is proprietary software. See the license terms included with the SDK for details.
