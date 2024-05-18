# KVKeychain 🔑

[![Swift](https://img.shields.io/badge/Swift-5.10-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A Swift package for managing key-value pairs securely using the Keychain, similar to UserDefaults.

## Features

- Store, retrieve, and delete key-value pairs securely in the Keychain
- Supports `Codable` types for easy encoding and decoding

## Installation

### Swift Package Manager

To integrate `KVKeychain` into your project using Swift Package Manager, add it to the dependencies in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/ssadel/KVKeychain.git", from: "1.0.0")
]
```

## Usage

After adding the package, import Keychain

```swift
import Keychain
```

Then you can use any of the 3 methods on the KVKeychain class

```swift
let key: String = "user_id"
let value: String = "123456"

// Set value
try? KVKeychain.set(value, forKey: key)

// Get value
try? KVKeychain.getValue(forKey: key) // 123456

// Update value
let newValue: String = "654321"
try? KVKeychain.set(newValue, forKey: key)

// Remove a key-value pair
try? KVKeychain.removeObject(forKey: key)
```
